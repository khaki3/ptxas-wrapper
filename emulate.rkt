#lang rosette

(require
 "ptx.rkt"
 "gen.rkt"
 "util.rkt"
 "ptx-sample.rkt"
 (only-in srfi/1
          delete-duplicates list-copy iota
          find fold any every
          lset-difference lset-intersection
          lset-adjoin lset-union)
 (only-in srfi/13 string-contains)
 racket/match
 rosette/solver/smt/z3)

(provide (all-defined-out))

;;
;; Coding rule: Avoid the use of let, especially letrec
;;

(define sema (make-semaphore 16))

(define-syntax thread-thunk
  (syntax-rules ()
    [(_ body ...)
     (thread
      (thunk (semaphore-wait sema)
             body ...
             (semaphore-post sema)))]))

(define-syntax receive-all
  (syntax-rules ()
    [(_ body ...)
     (let loop ([ret '()])
       (define r (thread-try-receive))
       (if r (loop (cons r ret)) ret))]))

(define-syntax solve-to
  (syntax-rules ()
    [(_ expr) (timeout 60 (solve expr))]))

(define-syntax verify-to
  (syntax-rules ()
    [(_ expr) (timeout 60 (verify expr))]))

(define-syntax timeout
  (syntax-rules ()
    [(_ n body ...)
     (let ()
       (define ct (current-thread))
       (define nt (thread (thunk (thread-send ct (begin body ...)))))
       (sync/timeout n nt)
       (kill-thread nt)
       (thread-try-receive))]))

(define (emulate x)
  (define ct (current-thread))
  (define in (iota (length x)))
  (for-each
   thread-wait
   (map
    (lambda (t i)
      (thread (thunk
       (with-handlers ([exn:fail?
                        (lambda (e)
                          (eprintf "~a\n" e) (thread-send ct (cons i t)))])
         (parameterize
             ([current-solver (z3)]
              [typeinfo-table (make-hash)]
              [cvta-table (make-hash)]
              [iterator-count 0]
              [f2r (make-hash)]
              [f2r-count 0])
           (with-terms
             (thread-send ct (cons i (emulate-top t))))
           (solver-shutdown (current-solver)))
         ))))
    x in ))
  (map cdr
       (sort (filter-map (lambda _ (thread-try-receive)) in) #:key car <)))

(define (emulate-top x)
  (clear-terms!)
  (match (car x)
    [(or 'module 'debugging 'storageN) x]

    ['linking  `(linking ,(~ x 1) ,(emulate-top (~ x 2)))]

    [(or 'kernel 'function) (emulate-block x)]))

(define (emulate-block x)
  (match (cdr x)
    [(list (and r (list 'storage _ ...)) ...
           (and name (? string?))
           (and p (list 'storage _ ...)) ...
           (and t (or (regexp #rx"^[.]")
                      (list (regexp #rx"[.]") _ ...))) ...
           stmt ...)
     (if (null? stmt) x
         `(,(car x) ,@r ,name ,@p ,@t
           ,@(interpret (append r p stmt)
                        (length (append r p)) )))]))

(define-syntax %define-symbolic
  (syntax-rules ()
    [(_ a type)
     (constant (string->symbol a) type)]))

(define-syntax add-special-regs!
  (syntax-rules ()
    [(_ env a spec)
     (let ()
       (define name (symbol->string (quote a)))
       (define type (spec->symbolic-type spec))
       (typeinfo-add name spec)
       (set! env (acons name (%define-symbolic name type) env)))]

    [(_ env a b ... spec)
     (begin
       (add-special-regs! env a spec)
       (add-special-regs! env b ... spec))]))

(define (find-in-symbols sym x)
  (find (curry symbol=? x) sym))

(define (loader? x)
  (find-in-symbols (list load8 load16 load32 load64 load128 loadf) x))

(define (loop-base? x)
  (find-in-symbols
   (list loop-base1 loop-base8 loop-base16 loop-base32
         loop-base64 loop-base128 loop-basef)
   x))

(define (addr-label? x)
  (find-in-symbols
   (list addr-const addr-global addr-local
         addr-param addr-shared addr-unknown)
   x))

(define (find-load x symbol)
  (match x
    [(expression op child ...)
     (define c (if (and (loader? (~ child 0))
                        (symbol=? symbol (~ child 1)))
                   (list (~ child 2)) '()))
     (append c (append-map (curryr find-load symbol) child))]

    [else '()]))

(define (replace-tid x)
  (define %tid
    (%define-symbolic "%tid"   (spec->symbolic-type '(".v4" ".u32"))))
  (define %_n (%define-symbolic "%_n" (bitvector 32)))
  (define %tid+n
    (concat (bvadd (extract 127 96 %tid) %_n) (extract 95 0 %tid)))

  (match x
    [(expression op child ...)
     (apply op (map replace-tid child))]

    [(constant id type)
     (if (symbol=? x %tid) %tid+n x)]

    [else x]))

(define f2r (make-parameter (make-hash)))
(define f2r-count (make-parameter 0))

(define (function->reg x)
  (define r (hash-ref (f2r) x #f))
  (unless r
    (define fn (match x [(expression _ fn _ ...) fn]))
    (define s
      (%define-symbolic (format "__~a_~a" fn (f2r-count)) (type-of x)))
    (f2r-count (+ (f2r-count) 1))
    (hash-set! (f2r) x s)
    (set! r s))
  r)

(define (replace-function x)
  (define app
    (match (loop-base1 (bv 0 1) 0) [(expression op _ ...) op]))

  (match x
    [(expression op child ...)
     (if (equal? op app)
         (function->reg x)
         (apply op (map replace-function child)))]

    [else x]
    ))

;; For not partially printed
(define (display-expression x [indent ""])
  (match x
    [(expression op child ...)
     (displayln (format "~a(~a" indent op) (current-error-port) )
     (for-each (curryr display-expression (string-append indent "  ")) child)
     (displayln (format "~a)" indent) (current-error-port) )]

    [else
     (displayln (format "~a~a" indent x) (current-error-port) )]
    ))

(define (extract-symbolics x)
  (filter (negate (disjoin loader? loop-base? addr-label?)) (symbolics x)))

(define (contain-tid? x)
  (define %tid
    (%define-symbolic "%tid" (spec->symbolic-type '(".v4" ".u32"))))
  (any (curry symbol=? %tid) (extract-symbolics x)))

(define (addr=? x y)
  (define sx (extract-symbolics x))
  (define sy (extract-symbolics y))
  (clear-vc!)
  (define %tid
    (%define-symbolic "%tid" (spec->symbolic-type '(".v4" ".u32"))))
  (define in (remove %tid (lset-intersection symbol=? sx sy) symbol=?))
  (define c (pair? in))
  (define s (and c (not (eq? (unsat) (solve-to (assert (bveq x y)))))))
  s)

;;
;; Check if the result of the load is available in succeeding loads
;; (This analysis was implemented for removing register initialization while
;;  confirming the shuffled values always loaded. Currently it's deprecated
;;  because it mostly neither affects performance nor is needed)
;;
;;  '( concerned-ld-hash . ( available-ld-hash ... ))
;;
;;  e.g.
;;    %x = available-ld
;;    // Is there any branch jump into between %x and %y?
;;    // -> if so, %x is not always available in the place of concerned-ld
;;    %y = concerned-ld
;;
;; TODO: integrate with 'interpret' (to have branch elimination)
;;
;; Note: 'interpret' only extracts sets of shuffle from top to bottom of loops.
;;       Loop scopes make sure there is no skip of %y after %x in the loop.
;;       Outside loops, loops do not affect the availability of shuffle;
;;       Then, scopes are used for checking the existance of %x in every case
;;
;; Addtionaly, there is live variable analysis to confirm the variable %x is
;; directly avaiable without the need of temporary variables
;;
(define (load-scopes cfg)

  (define reversed-mapping (cfg-reversed-mapping cfg))

  ;; Fetch the sequence of load hashes and output registers
  (define (track x)
    (define r (extract-destination-registers x))
    (match x
      [(list 'instruction "ld"
             (and opt (regexp #rx"^[.]")) ... d a)
       (append r (list (eq-hash-code x)))]

      [else r]))

  (define (backtrace succeeding)
    (define label (car succeeding))

    (match-let ([(list _ _ _ stmt ...) (assoc label cfg)])
      (define trace (append-map track (reverse stmt)))

      (define src (or (assoc-ref reversed-mapping label) '()))

      (define next (filter-not (curry index-of succeeding) src))
      (if (null? next) (list trace)
          (append-map
           (compose
            (curry map (curry append trace))
            backtrace
            (curryr cons succeeding)) next))))

  ;; '((ld/reg ..) ...)
  (define traces (backtrace (list "END_:")))

  ;; '((ld ...) ...)
  (define ld-trace (map (curry filter number?) traces))

  ;; Construct the return value
  (define hashes (delete-duplicates (apply append ld-trace)))

  (define ld-scope
    (map
     (lambda (h)
       ;; Elements after h for each trace
       (define e (map cdr (filter-map (curry member h) ld-trace)))
       ;; Elements always appearing before the load
       (define i (apply set-intersect e))
       (cons h i))
     hashes))

  ;; Check if there is no register update between loads
  (map
   (lambda (x)
     (define dst (car x))
     (define src
       (filter
        (lambda (s)
          (every
           (lambda (t)
             ;; No update after src until dst?
             (define remains (cdr (member s t)))
             (define reg (car remains))
             (define idx (index-of remains dst))
             (not (index-of (cdr (take remains idx)) reg)))
           ;; remove trace without dst -> reverse
           (map reverse (filter-map (curry member dst) traces))))
        (cdr x)))
     (cons dst src))
   ld-scope))

;;
;; Induction variable recognition
;;
;; '((loop-header .  ( ( reg . res )   ...)) ...)
;; res ::= (#t|#f /* Having += form? */
;;       |  #t|#f /* tid included in the form? */
;;       |  (dep ...)) /* for initialization (to check if tid is included) */
;;
;;   Currently only the first one is returned.
;;
;; Even having no += form, dep is necessary as converted to:
;;  -> loop or loop*tid (tid included)
;;     (if it's not incremental, they will disappear)
;;     (this works for nested loops also as it's applied to each loop)
;;
;; When having +=:
;;  -> a+loop or loop*tid
;;
;; Reference:
;; - R.A. van Engelen. Efficient Symbolic Analysis for Optimizing Compilers.
;;   2001
;; - R.A. van Engelen. Symbolic evaluation of chains of recurrences for loop
;;   optimization. 2000
;;
(define (recognize-giv loop cfg)

  (define (traverse label env [proceeding '()] [assumed '()])
    (define loop-header (if (pair? proceeding) (last proceeding) label))

    ;; if out-of-loop or passing again
    (if (or (not label) (index-of proceeding label)
            (not (index-of loop label)))
        ;; if it is in the loop header again
        (if (and (pair? proceeding) (equal? loop-header label)) (list env) '())

        (match-let ([(list _ dest1 dest2 stmt ...) (assoc label cfg)])
          (define dest (list dest1 dest2))
          (define next-assumed (list assumed assumed))
          (define condition (make-parameter #f))
          (define local-env (make-parameter (list-copy env)))
          (define local-accum (make-parameter '()))

          (for-each (curryr exec condition local-env local-accum) stmt)

          ;; next-env is created to make the conditional reg const
          ;; note: other registers than conditions could be done the same
          ;;       but it is little beneficial
          (define next-env (list (local-env) (local-env)))

          (for-each
           (match-lambda
             ;; Update branch conditions (assumed)
             [(list 'cond c name neg)
              (clear-vc!)
              (map (lambda (x) (assume x)) assumed) ; assume is a syntax
              (define b (bitvector->bool c))
              (define nf (bv (if neg 1 0) 1))
              (define nt (bvnot nf))

              (cond
                ;; No Branch
                [(eq? (solve-to (assert b)) (unsat))
                 (set! dest (list dest1))
                 (set! next-env (list (assoc-adjoin (local-env) name nf)))
                 (set! next-assumed (list (cons (not b) assumed)))]

                ;; Branch
                [(eq? (verify-to (assert b)) (unsat))
                 (set! dest (list dest2))
                 (set! next-env (list (assoc-adjoin (local-env) name nt)))
                 (set! next-assumed (list (cons b assumed)))]

                [else
                 (set! next-env (list (assoc-adjoin (local-env) name nf)
                                      (assoc-adjoin (local-env) name nf)))
                 (set! next-assumed (list (cons (not b) assumed)
                                          (cons b assumed)))])]

             ;; Invalidate (remove) branch conditions and loads w/ store idx
             ;; todo: load alignment (i.g. load32 and load64)
             [(list 'store hash symbol loader addr0 val)
              ;; only for global
              (when (and (or (symbol=? symbol addr-global)
                             (symbol=? symbol addr-shared))
                         (contain-tid? addr0))
                ;; Replace %tid with %tid + _n
                (define addr (replace-tid addr0))

                (define at
                  (if (symbol=? loader loadf)
                      (= (loader symbol addr) val)
                      (bveq (loader symbol addr) val)))

                (define new-assumed
                  (filter
                   (lambda (x)
                     (and ;; Having a conflicting address?
                      (any (curry addr=? addr) (find-load x symbol))
                      ;; todo: assume addr to be the same on at and x
                      ;; x can be always true with at?
                      (not (eq? (unsat)
                                (verify-to (begin (assume at) (assert x)))))))
                   assumed))

                (set! assumed new-assumed))]

             ;; Add to loads, update load-diffs
             [(list 'load hash symbol loader addr) #f])

           (reverse (local-accum)))

          (append-map
           (lambda (d e a)
             (traverse d e (cons label proceeding) a))
           dest next-env next-assumed))))

  ;; Flow-dep (ssa) -> Exec (reg from recent ones)
  (define top-env '())

  (add-special-regs! top-env %tid %ntid %ctaid %nctaid '(".v4" ".u32"))
  (add-special-regs! top-env %laneid %warpid %nwarpid %smid %nsmid '(".u32"))
  (add-special-regs! top-env %gridid WARP_SZ '(".u64"))

  (define it (extract-iterators loop cfg))
  (define st (dig (lambda (x) (and (pair? x) (eq? (car x) 'storageN))) cfg))

  (define condition (make-parameter #f))
  (define env   (make-parameter top-env))
  (define accum (make-parameter '()))

  (for-each (curryr exec-storage condition env accum) st)

  (define orig (env))

  (define ssa (traverse (car loop) (env)))

  ;; Anti-dep (CR) -> ( (r1)->(r2) ) ; reg reflection from head to tail
  ;; (wrap-arround apply (just expansion; same form as ssa since no CR^-1))
  ;; (range of loop is not sure; thus cr^-1 is not performed here)
  (define cr
    (map
     (lambda (s)
       (let rec ([s s] [p '()])
         (if (null? s) p
             (rec (cdr s)
                  (cons (cons (caar s) (expand (cdar s) p)) p)))))
     ssa))

  (filter
   (lambda (i)
     (define exprs (map (curryr assoc-ref i) cr))
     (define var (assoc-ref orig i))
     (every (curryr incremental? var i) exprs))
   it))

(define (expand r env)
  (match r
    [(expression op child ...)
     (apply op (map (curryr expand env) child))]

    [(constant id type)
     (or (and (symbol? id) (assoc-ref env (symbol->string id))) r)]

    [else r]))

(define (incremental? expr var name)
  ;; expr (where var=0)
  (define z (expand expr (list (cons name (bvempty var)))))

  (define v (conversion-cvt var
                            (format ".u~a" (bv-size var))
                            (format ".u~a" (bv-size expr))))

  ;; expr - expr(var=0) = var
  (eq? (unsat)
       (verify-to
        (begin
          (assert (bveq (bvsub expr z) v))))))

(define (bvempty x)
  (bv 0 (bv-size x)))

(define (interpret stmt header-size)
  ;; Extract the control-flow graph
  (define cfg (extract-cfg stmt))
  ;; Check updated reg in loop -> make them unbounded
  ;; b = a
  ;; a = a+1
  ;; => b, a -> unbounded before entring the block;
  ;;    however, b would be symbolically equal to `a` following the execution
  (define loops (extract-loops cfg))
  (define iterators
    (map (lambda (l) (cons (car l) (extract-iterators l cfg))) loops))
  (define incremental
    (let ()
      (define ct (current-thread))
      (for-each
       thread-wait
       (map (lambda (l)
              (thread-thunk (with-terms
                              (parameterize ([current-solver (z3)])
                                (thread-send ct (cons (car l) (recognize-giv l cfg))))))) loops))
      (receive-all)))

  ;;
  ;; Follow the cfg -> exit if re-entered to loops
  ;;

  (define previous '())

  (define load-diffs '())

  ;; Skip validation of already-invalidated pairs
  (define invalid-pairs (make-hash))

  (define (traverse label env [proceeding '()] [assumed '()] [loads '()])
    (define pre (assoc-ref previous label))

    (if (or (not label)
            (index-of proceeding label)
            (and pre (any (compose null? (curry lset-difference equal? env))
                          pre)))
        '()

        (match-let ([(list _ dest1 dest2 stmt ...) (assoc label cfg)])
          (define dest (list dest1 dest2))
          (define next-assumed (list assumed assumed))
          (define condition (make-parameter #f))
          (define local-env (make-parameter (list-copy env)))
          (define local-accum (make-parameter '()))
          (define new-pre (cons env (or pre '())))
          (set! previous (assoc-adjoin previous label new-pre))

          ;; Loop header check
          ;; Note: Since the loop is always tracked forwardly and
          ;;   the loop-base encloses a unique id,
          ;;   there is no need to check if the loop-base abstraction
          ;;   contains any load to be invalidated by storing.
          ;;
          (define it (assoc label iterators))
          (define in (assoc label incremental))
          (when it
            (local-env
             (map
              (lambda (x)
                (cond [(not (member (car x) it)) x]

                      [(member (car x) in)
                       (cons (car x)
                             (bvadd (cdr x) (loop-base (bvempty (cdr x)))))]

                      [else (cons (car x)
                                  (loop-base (bvempty (cdr x))))]))
              (local-env))))

          (for-each (curryr exec condition local-env local-accum) stmt)

          ;; next-env is created to make the conditional reg const
          ;; note: other registers than conditions could be done the same
          ;;       but it is little beneficial
          (define next-env (list (local-env) (local-env)))

          (for-each
           (match-lambda
             ;; Update branch conditions (assumed)
             [(list 'cond c name neg)
              (clear-vc!)
              (map (lambda (x) (assume x)) assumed) ; assume is a syntax
              (define b (bitvector->bool c))
              (define nf (bv (if neg 1 0) 1))
              (define nt (bvnot nf))

              (cond
                ;; No Branch
                [(eq? (solve-to (assert b)) (unsat))
                 (set! dest (list dest1))
                 (set! next-env (list (assoc-adjoin (local-env) name nf)))
                 (set! next-assumed (list (cons (not b) assumed)))]

                ;; Branch
                [(eq? (verify-to (assert b)) (unsat))
                 (set! dest (list dest2))
                 (set! next-env (list (assoc-adjoin (local-env) name nt)))
                 (set! next-assumed (list (cons b assumed)))]

                [else
                 (set! next-env (list (assoc-adjoin (local-env) name nf)
                                      (assoc-adjoin (local-env) name nf)))
                 (set! next-assumed (list (cons (not b) assumed)
                                          (cons b assumed)))])]

             ;; Invalidate (remove) branch conditions and loads w/ store idx
             ;; todo: load alignment (i.g. load32 and load64)
             [(list 'store hash symbol loader addr0 val)
              ;; only for global
              (when (and (or (symbol=? symbol addr-global)
                             (symbol=? symbol addr-shared))
                         (contain-tid? addr0))
                ;; Replace %tid with %tid + _n
                (define addr (replace-tid addr0))

                (define at
                  (if (symbol=? loader loadf)
                      (= (loader symbol addr) val)
                      (bveq (loader symbol addr) val)))

                (define new-assumed
                  (filter
                   (lambda (x)
                     (and ;; Having a conflicting address?
                      (any (curry addr=? addr) (find-load x symbol))
                      ;; todo: assume addr to be the same on at and x
                      ;; x can be always true with at?
                      (not (eq? (unsat)
                                (verify-to (begin (assume at) (assert x)))))))
                   assumed))

                ;; addr=? or containing loads begin addr=?
                ;;
                ;; e.g. The index x[1] should be removed due to the store.
                ;; x = a[x[1]]
                ;; x[n] = m
                ;; y = a[x[l]+10]
                ;;
                (define new-loads
                  (map
                   (lambda (x)
                     (if (or (addr=? (cdr x) addr)
                             (any (curry addr=? addr)
                                  (find-load (cdr x) symbol))) x
                         (cons (car x) #f)
                         ))
                   loads))

                (set! assumed new-assumed)
                (set! loads new-loads))]

             ;; Add to loads, update load-diffs
             [(list 'load hash symbol loader addr)
              ;; only for global
              (when (and (or (symbol=? symbol addr-global)
                             (symbol=? symbol addr-shared))
                         (contain-tid? addr))
                (define diff-pre (or (assoc-ref load-diffs hash) '()))
                (define ct (current-thread))

                (for-each
                 thread-wait
                 (map
                  (lambda (x)
                   (thread-thunk
                   (unless (cdr x) (thread-send ct x))
                   (when (cdr x)
                   (with-terms
                   (with-handlers ([exn:fail? (curry eprintf "~a\n")])
                   (parameterize ([current-solver (z3)])
                     (define xh (car x))
                     (define ra (replace-function addr))
                     (define xa (replace-function (replace-tid (cdr x))))
                     (define %_n (%define-symbolic "%_n" (bitvector 32)))
                     (define pair (cons hash xh))
                     (define in (hash-ref invalid-pairs pair #f))

                     (define ret (cons xh #f))

                     ;; (displayln '---)
                     ;; (display-expression ra)
                     ;; (display-expression xa)

                     (clear-vc!)

                     (when (not in)
                       (define s
                         (solve-to
                          (begin
                            (assume
                             (bvsle %_n (bv 31 32)))
                            (assume
                             (bvsge %_n (bv -31 32)))
                            (assert (bveq ra xa)))))

                       (define solved (and (sat? s) (not (unknown? s))))

                       ;; (if (sat? s)
                       ;;     (displayln (model s))
                       ;;     (displayln (core s)))

                       (define v
                         (and solved
                              (verify-to (begin
                                        (assume (bveq %_n (evaluate %_n s)))
                                        (assert (bveq ra xa))))))

                       ;; (when (and solved (sat? v))
                       ;;   (displayln (model v)))

                       ;; (when (and solved (not (sat? v)))
                       ;;   (println (bitvector->integer (evaluate %_n s))))

                       (if (or (not solved) (sat? v))
                           (hash-set! invalid-pairs pair #t)
                           (set! ret (cons xh (bitvector->integer
                                               (evaluate %_n s) )))))

                     (thread-send ct ret)
                     (solver-shutdown (current-solver))
                     ))))))

                  loads))

                (define diff
                  (append
                   diff-pre
                   (receive-all) ))

                (set! loads (cons (cons hash addr) loads))
                (set! load-diffs (assoc-adjoin load-diffs hash diff)))])

           (reverse (local-accum)))

          (for-each
           (lambda (d e a)
             (traverse d e (cons label proceeding) a loads))
           dest next-env next-assumed))))

  (define top-label (caar cfg))
  (define top-env '())

  (add-special-regs! top-env %tid %ntid %ctaid %nctaid '(".v4" ".u32"))
  (add-special-regs! top-env %laneid %warpid %nwarpid %smid %nsmid '(".u32"))
  (add-special-regs! top-env %gridid WARP_SZ '(".u64"))

  (traverse top-label top-env)

  (gen (drop stmt header-size) load-diffs (init-pos cfg loops) ))

(define (exec x condition env accum)
  (define fn
    (match x
      [(regexp #rx"^@") exec-cond]

      [(list (or 'storage 'storageN) _ ...) exec-storage]

      [(list 'group _ ...) exec-group]

      [(list 'instruction _ ...) exec-insn]

      [(list 'debugging _ ...) exec-debugging]

      [(list 'prototype _ ...) #f]

      [(list 'pragma _) #f]

      [(list 'controlflow _ ...)
       (error "UNSUPPORTED")]))

  (and fn (fn x condition env accum)))

;; Update condition
(define (exec-cond x condition env accum)
  (define m (regexp-match #rx"^@(!)?(.*)$" x))
  (define negation (~ m 1))
  (define name (~ m 2))
  (define val (assoc-ref (env) name))
  (env (assoc-adjoin (env) "_cond_name" name))
  (env (assoc-adjoin (env) "_cond_neg" negation))
  ;; condition should be a bitvector to be distinguished from unset (#f)
  (condition (if negation (bvnot val) val)))

(define (type->bit type)
  (match type
    [".pred" 1]

    [(or ".s8" ".u8" ".b8") 8]

    [(or ".f16" ".s16" ".u16" ".b16") 16]

    [(or ".f32" ".f16x2" ".s32" ".u32" ".b32") 32]

    [(or ".f64" ".s64" ".u64" ".b64") 64]

    [(or ".f128" ".s128" ".u128" ".b128") 128]

    [else #f]))

(define (spec->symbolic-type spec)
  (define bit (type->bit (last spec)))
  (define vec (vecsize spec)) ; vector -> bit x N
  (bitvector (* bit vec)))

(define (vecsize spec)
  (cond [(member ".v2" spec) 2]
        [(member ".v4" spec) 4]
        [else 1]))

(define typeinfo-table (make-parameter (make-hash)))

(define (typeinfo-ref name x)
  (define r (hash-ref (typeinfo-table) name #f))
  (and r (assoc-ref r x)))

(define (typeinfo-add name spec)
  (define alist
    `((spec . ,spec)
      (type . ,(last spec))
      (vecsize . ,(vecsize spec))))
  (hash-set! (typeinfo-table) name alist))

(define (typeinfo-rm name)
  (clear-terms! (list (%define-symbolic name (bitvector 1))))
  (hash-remove! (typeinfo-table) name))

;; Update env
(define/match (exec-storage x condition env accum)
  [((list _ (and spec (regexp #rx"^[.]")) ... decl ...) _ _ _)
   ;; todo: more types (currently .reg only)
   (match (car spec)
     ;; todo: use init for .global & .const
     [(or ".const" ".local" ".shared" ".tex") #f]

     [(or ".reg" ".param")
      (define space (car spec))

      (when (equal? space ".param")
        (set! spec (append spec '(".u32"))))

      (define symbolic-type (spec->symbolic-type spec))

      (for ([d decl])
        (define pat  (if (string? d) d (~ d 0)))
        (define init (if (string? d) #f (~ d 1)))
        (define m (regexp-match #rx"^(.*)<(.*)>$" pat))
        (define name (if m (~ m 1) pat))
        (define num (if m (string->number (~ m 2)) #f))

        (define regs
          (if num (map (curry format "~a~a" name) (iota num))
              (list name)))

        (env
         (append
          (map
           (lambda (x)
             (typeinfo-add x spec)
             (cons x (%define-symbolic x symbolic-type)))
           regs)
          (env)))
        )])])

;; Recursive; Restore local-env
(define (exec-group x condition env accum)
  (define regs (map car (env)))
  (for-each (curryr exec condition env accum) (cdr x))
  (env (filter-map
        (lambda (a) (if (member (car a) regs) a
                        (and (typeinfo-rm (car a)) #f) ))
        (env))))

;; Recursive
(define (exec-debugging x condition env accum)
  (match (~ x 1)
    [(or ".file" ".loc") #f]

    [".section"
     (exec-group (~ x 3) condition env accum)]))

(define bv->f16   (%define-symbolic "bv->f16"   (~> (bitvector 16) real?)))
(define bv->f32   (%define-symbolic "bv->f32"   (~> (bitvector 32) real?)))
(define bv->f64   (%define-symbolic "bv->f64"   (~> (bitvector 64) real?)))

(define f16->bv   (%define-symbolic "f16->bv"   (~> real? (bitvector 16))))
(define f32->bv   (%define-symbolic "f32->bv"   (~> real? (bitvector 32))))
(define f64->bv   (%define-symbolic "f64->bv"   (~> real? (bitvector 64))))

(define (wrap bv type)
  (match type
    [".f16x2" bv]

    [(not (regexp "^\\.f")) bv]

    [else ; float
     (match bv
       [(term (list _ (constant (or 'f16->bv 'f32->bv 'f64->bv) _)
                    (? real? r)) _) r]

       [else
        (match type
          [".f16"   (bv->f16 bv)]
          [".f32"   (bv->f32 bv)]
          [".f64"   (bv->f64 bv)]
          [else (error (format "Invalid type: ~a" type))])])]))

(define (unwrap x type)
  (match type
    [".f16x2" x]

    [(not (regexp "^\\.f")) x]

    [else ; float
     (match x
       [(term
         (list _ (constant (or 'bv->f16 'bv->f32 'bv->f64) _)
               (? bv? bv)) _) bv]

       [else
        (match type
          [".f16"   (f16->bv x)]
          [".f32"   (f32->bv x)]
          [".f64"   (f64->bv x)]
          [else (error (format "Invalid type: ~a" type))])])]))

;; PTX Manual 9.4 (ld, st, cvt)
;; > For convenience, ld, st, and cvt instructions permit source and
;; > destination data operands to be wider than the instruction-type size

;; Convert bv as `from` to `to`; then wrap it
(define (conversion-src bv from to)
  (define (chop n) (lambda (x) (extract (- n 1) 0 x)))
  (define (invalid) (error (format "Invalid conversion: ~a -> ~a" from to)))

  (define fn
    (match `(,from ,to)
      [(list a a) values]

      [(list ".b32" ".f16x2") values]
      [(list ".b64" ".f16x2") (chop 32)]
      [(list _ ".f16x2") (invalid)]

      [(list ".f16x2" ".b8") (chop 8)]
      [(list ".f16x2" ".b16") (chop 16)]
      [(list ".f16x2" ".b32") values]
      [(list ".f16x2" _) (invalid)]

      [(or (list (regexp "^\\.[bsu](.*)$" (list _ n))
                 (regexp "^\\.[bsu](.*)$" (list _ m)))
           (list (regexp "^\\.b(.*)$" (list _ n))
                 (regexp "^\\.f(.*)$" (list _ m)))
           (list (regexp "^\\.f(.*)$" (list _ n))
                 (regexp "^\\.b(.*)$" (list _ m))))
       (define f (string->number n))
       (define t (string->number m))
       (cond [(= f t) values]
             [(> f t) (chop t)]
             [else (invalid)])]

      [else (invalid)]))

  (wrap (fn bv) to))

;; Unwrap; then, convert it from `from` to `to`
(define (conversion-dst val from to)
  (define (zext n) (lambda (x) (zero-extend x (bitvector n))))
  (define (sext n) (lambda (x) (sign-extend x (bitvector n))))
  (define (invalid) (error (format "Invalid conversion: ~a -> ~a" from to)))

  (define fn
    (match `(,from ,to)
      [(list a a) values]

      [(list ".b8" ".f16x2") (zext 32)]
      [(list ".b16" ".f16x2") (zext 32)]
      [(list ".b32" ".f16x2") values]
      [(list _ ".f16x2") (invalid)]

      [(list ".f16x2" ".b32") values]
      [(list ".f16x2" ".b64") (zext 64)]
      [(list ".f16x2" _) (invalid)]

      [(or (list (regexp "^\\.[bsu](.*)$" (list _ n))
                 (regexp "^\\.[bsu](.*)$" (list _ m)))
           (list (regexp "^\\.b(.*)$" (list _ n))
                 (regexp "^\\.f(.*)$" (list _ m)))
           (list (regexp "^\\.f(.*)$" (list _ n))
                 (regexp "^\\.b(.*)$" (list _ m))))
       (define f (string->number n))
       (define t (string->number m))
       (cond [(= f t) values]
             [(> f t) (invalid)]
             [(regexp-match "^\\.s" from) (sext t)]
             [else (zext t)])]

      [else (invalid)]))

  (fn (unwrap val from)))

(define %round (%define-symbolic "round" (~> real? integer?)))

;; PTX Manual 6.5
(define (conversion-cvt val from to)
  (define (chop n) (lambda (x) (extract (- n 1) 0 x)))
  (define (zext n) (lambda (x) (zero-extend x (bitvector n))))
  (define (sext n) (lambda (x) (sign-extend x (bitvector n))))
  (define (f2s n) (lambda (x) (integer->bitvector (%round x) (bitvector n))))
  (define (f2u n) (lambda (x) (integer->bitvector (%round x) (bitvector n))))
  (define (s2f) (lambda (x) (bitvector->integer x)))
  (define (u2f) (lambda (x) (bitvector->natural x)))
  (define (invalid) (error (format "Invalid conversion: ~a -> ~a" from to)))

  (define fn
    (match `(,from ,to)
      [(list a a)
       values]

      [(list ".f32" ".bf16")
       (curryr unwrap ".f16")]

      [(list ".f32" ".tf32")
       (curryr unwrap ".f32")]

      [(list (regexp "^\\.f") (regexp "^\\.f"))
       values]

      [(list (regexp "^\\.f") (regexp "^\\.s(.*)$" (list _ m)))
       (f2s (string->number m))]

      [(list (regexp "^\\.f") (regexp "^\\.u(.*)$" (list _ m)))
       (f2u (string->number m))]

      [(list (regexp "^\\.s(.*)$" (list _ n)) (regexp "^\\.f"))
       (s2f)]

      [(list (regexp "^\\.u(.*)$" (list _ n)) (regexp "^\\.f"))
       (u2f)]

      [(list (regexp "^\\.[su](.*)$" (list _ n))
             (regexp "^\\.[su](.*)$" (list _ m)))
       (define f (string->number n))
       (define t (string->number m))
       (cond [(= f t) values]
             [(> f t) (chop t)]
             [(regexp-match "^\\.s" from) (sext t)]
             [else (zext t)])]

      [else (invalid)]))

  (fn val))

(define (read-literal str type)
  ;; todo: implement literal with the array support
  (read-constant str type))

(define (read-constant str type)
  (define minus (char=? (string-ref str 0) #\-))
  (define digits (if minus (substring str 1) str))
  (define bit (type->bit type))
  (define signed? (curry equal? "U"))
  (define (sign m x) (if (and x m) (- x) x))
  (define num
    (match digits
      ;; real
      [(regexp "\\.")
       (sign minus (string->number digits))]

      ;; real
      [(regexp "^0[fFdD](.*)$" (list _ body))
       ;; ptx is little endian, but not in constants
       ;; > mov.f32  $f3, 0F3f800000;       //  1.0
       (define x
         (sign minus
               (floating-point-bytes->real (hexstring->bytes body) #t)))
       (if (rational? x) x 999999999999.9)]

      ;; hex
      ;; > Unary plus and minus preserve the type of the input operand
      [(regexp "^0[xX]([0-9A-Fa-f]+)(U?)$" (list _ body u))
       (sign (signed? u) (string->number body 16))]

      ;; oct
      [(regexp "^0([0-7]+)(U?)$" (list _ body u))
       (sign (signed? u) (string->number body 8))]

      ;; bin
      [(regexp "^0[bB]([01]+)(U?)$" (list _ body u))
       (sign (signed? u) (string->number body 2))]

      ;; dec
      [else
       (sign minus (string->number digits))]))

  (cond [(not num) #f]

        [(flonum? num) num]

        [else (bv num bit)]))

(define (bv-size bv)
  (bitvector-size (type-of bv)))

(define (bitvector-split val n)
  (define size (bv-size val))
  (define step (- (/ size n)))
  (define starts (iota n (- size 1) step))
  (define ends (iota n (+ size step) step))
  (map (curryr extract val) starts ends))

(define (vec-pos memb elmnum)
  (match memb
    [(or ".x" ".r") (if (= elmnum 2) 2 4)]
    [(or ".y" ".g") (if (= elmnum 2) 1 3)]
    [(or ".z" ".b") 2]
    [(or ".w" ".a") 1]))

(define (vec-ref val memb elmnum)
  (define size (bv-size val))
  (define bit (/ size elmnum))
  (define pos (vec-pos memb elmnum))
  (define start (- (* pos bit) 1))
  (define end (* (- pos 1) bit))
  (extract start end val))

(define (vec-update val x memb elmnum)
  (define size (bv-size val))
  (define bit (/ size elmnum))
  (define pos (vec-pos memb elmnum))
  ; (bv-size x) == bit
  (define start (- (* pos bit) 1))
  (define end (* (- pos 1) bit))

  (define head (- size 1))
  (define tmp1 (if (= start head) x
                   (concat (extract head (+ start 1) val) x)))
  (define tmp2 (if (= end 0) tmp1
                   (concat tmp1 (extract (- end 1) 0 val))))
  tmp2)

;; type is for conversion
(define (read-reg str type env)
  ;; check vector access + offset
  (define m (regexp-match "^([^\\.+]*)(\\.[^+]*)?(\\+(.*))?$" str))
  (define name (if m (~ m 1) str))
  (define memb (if m (~ m 2) #f))
  (and-let1 val (assoc-ref (env) name)
    (define vec (typeinfo-ref name 'vecsize))
    (define ref (if memb (vec-ref val memb vec) val))
    ;; offset only for .s32
    (define offset (and m (~ m 4) (equal? type ".s32")
                        (read-constant (~ m 4) ".s32")))
    (define regtype (typeinfo-ref name 'type))
    ;; e.g. .v2.u32 is converted from .b64 to `type`
    (define reftype (if (and (not memb) (> vec 1))
                        (type-binary (type-vec regtype vec)) regtype))
    (define conv (conversion-src ref reftype type))
    (if offset (bvadd conv offset) conv)))

(define (type-vec type mul)
  (match (and (> mul 1) type)
    [#f type]

    [".f16x2" (format ".b~a" (* 32 mul))]

    [(regexp "^(..)(.*)$" (list _ pre size))
     (define newsize (* (string->number size) mul))
     (format "~a~a" ".b" newsize)]))

(define (type-upsize type mul)
  (match (and (> mul 1) type)
    [#f type]

    [".f16x2" (format ".f~a" (* 32 mul))]

    [(regexp "^(..)(.*)$" (list _ pre size))
     (define newsize (* (string->number size) mul))
     (format "~a~a" pre newsize)]))

(define (type-downsize type div)
  (match (and (> div 1) type)
    [#f type]

    [".f16x2" (format ".f~a" (/ 32 div))]

    [(regexp "^(..)(.*)$" (list _ pre size))
     (define newsize (/ (string->number size) div))
     (format "~a~a" pre newsize)]))

(define (type-binary type)
  (match type
    [".f16x2" ".b32"]

    [(regexp "^..(.*)$" (list _ size))
     (format ".b~a" size)]))

(define (read-vec str type env)
  (and-let1 m (regexp-match "^{(.*)}$" str)
    (define src (string-split (~ m 1) ","))
    ;; vector is fetched as .bN
    (define subtype (type-binary (type-downsize type (length src))))
    (define vals (map (curryr read-reg subtype env) src))
    (apply concat vals)))

;; variables except .reg are treated as addresses
(define (read-addr str type)
  ;; Check addr+offset
  (define m (regexp-match "^(.*)\\+(.*)$" str))
  (define basic-type ".u64")
  (define bit (type->bit basic-type))
  (define offset (if m (read-constant (~ m 2) basic-type) (bv 0 bit)))
  (define s (if m (~ m 1) str))
  (conversion-src (bvadd (%define-symbolic s (bitvector bit)) offset)
                  basic-type type))

(define (read-src src type env)
  (or (read-constant src type)
      (read-vec src type env)
      (read-reg src type env)
      (read-addr src type)))

(define (write-dst dst val condition type env)
  (or (write-vec dst val condition type env)
      (write-reg dst val condition type env)))

;; type is for conversion
(define (write-reg dst val condition type env)
  ;; check vector access
  (define m (regexp-match "^(.*)(\\..*)$" dst))
  (define name (if m (~ m 1) dst))
  (define memb (if m (~ m 2) #f))
  (define orig (assoc-ref (env) name))
  (define vec (typeinfo-ref name 'vecsize))
  (define regtype (typeinfo-ref name 'type))
  ;; e.g. .v2.u32 is converted from `type` to .b64
  (define reftype (if (and (not memb) (> vec 1))
                      (type-binary (type-vec regtype vec)) regtype))
  (define bv (conversion-dst val type reftype))
  (define newval (if memb (vec-update orig bv memb vec) bv))
  (env-adjoin env name orig newval condition))

(define (write-vec dst val condition type env)
  (and-let1 m (regexp-match "^{(.*)}$" dst)
    (define out (string-split (~ m 1) ","))
    (define len (length out))
    ;; vector is treated as .bN
    (define bv (conversion-dst val type type))
    (define subtype (type-binary (type-downsize type len))) ;; .bN
    (define sp (bitvector-split bv len))
    (for-each (curryr write-reg condition subtype env) out sp)))

(define (env-adjoin env key orig val condition)
  (define c (condition))
  (define newval (if (or (not c) (not (bvzero? c))) val orig))
  (env (assoc-adjoin (env) key newval)))

(define (find-in-spec spec terms)
  (find (curryr member terms) spec))

(define (address-space spec)
  (find-in-spec spec '(".const" ".global" ".local" ".param" ".shared")))

(define (atom-op spec)
  (find-in-spec spec '(".and" ".or" ".xor" ".cas" ".exch"
                       ".add" ".inc" ".dec" ".min" ".max")))

(define-symbolic
  addr-const addr-global addr-local addr-param addr-shared addr-unknown
  integer?)

(define (symbol=? a1 a2)
  (match (list a1 a2)
    [(list (constant i1 _) (constant i2 _))
     (equal? i1 i2)]

    [else #f]))

(define-symbolic load8   (~> integer? (bitvector 32) (bitvector 8)))
(define-symbolic load16  (~> integer? (bitvector 32) (bitvector 16)))
(define-symbolic load32  (~> integer? (bitvector 32) (bitvector 32)))
(define-symbolic load64  (~> integer? (bitvector 32) (bitvector 64)))
(define-symbolic load128 (~> integer? (bitvector 32) (bitvector 128)))
(define-symbolic loadf   (~> integer? (bitvector 32) real?))

(define (select-loader type)
  (define bit (type->bit type))
  (match bit
    [8   load8]
    [16  load16]
    [32  load32]
    [64  load64]
    [128 load128]
    #;['f  loadf]))

(define-symbolic loop-base1   (~> (bitvector 1)   integer? (bitvector 1)))
(define-symbolic loop-base8   (~> (bitvector 8)   integer? (bitvector 8)))
(define-symbolic loop-base16  (~> (bitvector 16)  integer? (bitvector 16)))
(define-symbolic loop-base32  (~> (bitvector 32)  integer? (bitvector 32)))
(define-symbolic loop-base64  (~> (bitvector 64)  integer? (bitvector 64)))
(define-symbolic loop-base128 (~> (bitvector 128) integer? (bitvector 128)))
(define-symbolic loop-basef   (~> real?           integer? real?))

(define iterator-count (make-parameter 0))

(define (loop-base x)
  (define bit (if (bv? x) (bv-size x) 'f))
  (define fn
    (match bit
      [1   loop-base1]
      [8   loop-base8]
      [16  loop-base16]
      [32  loop-base32]
      [64  loop-base64]
      [128 loop-base128]
      ['f  loop-basef]))
  (iterator-count (+ (iterator-count) 1))
  (fn x (iterator-count)))

(define (space->symbol space addr)
  (match space
    [".const"  addr-const]
    [".global" addr-global]
    [".local"  addr-local]
    [".param"  addr-param]
    [".shared" addr-shared]
    [#f        (or (cvta-check addr) addr-global)]))

(define cvta-table (make-parameter (make-hash)))

(define (cvta-set addr space)
  (hash-set! (cvta-table) addr (space->symbol space #f)))

(define (cvta-check addr)
  (or (hash-ref (cvta-table) addr #f)

      (match addr
        [(expression op child ...)
         (and (not (loader? (~ child 0)))
              (any cvta-check child))]

        [else #f])))

#|
> Semantics
> d = a;  // variable a
> d = *a; // register a
(9.7.8.8. Data Movement and Conversion Instructions: ld)

This indicates the relation between variables. To track actual values:
  d <= *a;  // variable a
  d <= **a; // register a
|#

(define (load-mem src space type env accum insn)
  (and-let1 m (regexp-match "^\\[(.*)\\]$" src)
    (define term (~ m 1))
    (define addr (read-src term ".s32" env))
    (define loader (select-loader type))
    (define symbol (space->symbol space addr))
    (define bv (loader symbol addr))
    (accum (cons (list 'load (eq-hash-code insn) symbol loader addr)
                 (accum)))
    (define r
      (and (equal? space ".param") (not (string-contains term "+"))
           (assoc-ref (env) (format "__st_~a" term))))
    (or r (conversion-src bv type type))))

(define (store-mem dst val space type env accum insn)
  (and-let1 m (regexp-match "^\\[(.*)\\]$" dst)
    (define term (~ m 1))
    (define addr (read-src term ".s32" env))
    (define loader (select-loader type))
    (define symbol (space->symbol space addr))
    (define cnv-val (conversion-dst val type type))
    (when (and (equal? space ".param") (not (string-contains term "+")))
      (env (assoc-adjoin (env) (format "__st_~a" term) cnv-val)))
    (accum (cons (list 'store (eq-hash-code insn) symbol loader addr cnv-val)
                 (accum)))))

(define (make-pred val)
  (if val (bv 1 1) (bv 0 1)))

(define (pair-dst dst)
  (define m (regexp-match "^(.*)|(.*)$" dst))
  (if m
      (values (~ m 1) (~ m 2))
      (values dst #f)))

;; Execute instruction (Update env/accum)
(define (exec-insn x condition env accum)
  (match (cdr x)
    [(list opcode (and spec (regexp #rx"^[.]")) ... oprand ...)
     (match opcode
       ["mov"
        (define type (last spec))
        (define vec (vecsize spec))
        (define newtype (type-vec type vec))
        (define d (read-src (~ oprand 1) newtype env))
        (write-dst (~ oprand 0) d condition newtype env)]

       ["cvta"
        ;;
        ;; LD/ST with state space -> non-generic address
        ;; => cvta.to.space.* can be ignore
        ;;
        ;; LD/ST without state space -> generic address (useful for switching)
        ;; => For cvta.space.*, address information has to be tracked.
        ;;    (Unsupported: generic address stored in memories)
        ;;
        (define type (last spec))
        (define vec (vecsize spec))
        (define newtype (type-vec type vec))
        (define d (read-src (~ oprand 1) newtype env))
        (when (not (equal? (~ spec 0) ".to"))
          (cvta-set d (~ spec 0)))
        (write-dst (~ oprand 0) d condition newtype env)]

       ["ld"
        (define type (last spec))
        (define vec (vecsize spec))
        (define space (address-space spec))
        (define newtype (type-vec type vec))
        (define d (load-mem (~ oprand 1) space newtype env accum x))
        (write-dst (~ oprand 0) d condition newtype env)]

       ["st"
        (define type (last spec))
        (define vec (vecsize spec))
        (define space (address-space spec))
        (define newtype (type-vec type vec))
        (define b (read-src (~ oprand 1) newtype env))
        (store-mem (~ oprand 0) b space newtype env accum x)]

       ["cvt"
        (when (equal? (~ spec 0) ".pack")
          (error "cvt.pack is not supported"))

        (define types (take-right spec 2))
        (define dtype (~ types 0))
        (define atype (~ types 1))

        (when (or (equal? dtype ".f16x2") (equal? dtype ".bf16x2"))
          (error-f16x2))

        (define a (read-src (~ oprand 1) atype env))
        (define d (conversion-cvt a atype dtype))

        (write-dst (~ oprand 0) d condition dtype env)]

       [(or "add" "sub" "mul" "div" "min" "max" "mad" "fma")
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 2) type env))
        (define fn
          (match type
            [".f16x2" (error-f16x2)]

            [(regexp "^\\.f")
             (match opcode
               ["add" +]
               ["sub" -]
               ["mul" *]
               ["div" /]
               ["mad" *]
               ["fma" *]
               ["min" min]
               ["max" max])]

            [(regexp "^\\.s")
             (match opcode
               ["add" bvadd]
               ["sub" bvsub]
               ["mul" bvmul]
               ["div" bvsdiv]
               ["mad" bvmul]
               ["min" bvsmin]
               ["max" bvsmax])]

            [(regexp "^\\.u")
             (match opcode
               ["add" bvadd]
               ["sub" bvsub]
               ["mul" bvmul]
               ["div" bvudiv]
               ["mad" bvmul]
               ["min" bvumin]
               ["max" bvumax])]

            [else (error (format "Invalid type for ~a: ~a" opcode type))]))

        (define d (fn a b))

        (define trans (find-in-spec spec '(".wide" ".hi" ".lo")))

        (when (and (or (equal? opcode "mad") (equal? opcode "fma"))
                   (regexp-match "^\\.f" type))
          (define c (read-src (~ oprand 3) type env))
          (set! d (+ d c)))

        (when trans
          (define newtype (type-upsize type 2))
          (define obit (type->bit type))
          (define nbit (type->bit newtype))

          (if (regexp-match "^\\.s" type)
              (begin
                (set! a (sign-extend a (bitvector nbit)))
                (set! b (sign-extend b (bitvector nbit))))
              (begin
                (set! a (zero-extend a (bitvector nbit)))
                (set! b (zero-extend b (bitvector nbit)))))

          (define tmp (fn a b))

          (match trans
            [".wide"
             (set! type newtype)]

            [".hi"
             (set! tmp (extract (- nbit 1) obit tmp))]

            [".lo"
             (set! tmp (extract (- obit 1) 0 tmp))])

          (set! d tmp)

          (when (equal? opcode "mad")
            (define c (read-src (~ oprand 3) type env))
            (set! d (bvadd tmp c))))

        (write-dst (~ oprand 0) d condition type env)]

       ["neg"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))

        (define fn
          (match type
            [".f16x2" (error-f16x2)]

            [(regexp "^\\.f") -]

            [(regexp "^\\.[su]") bvneg]))

        (define d (fn a))
        (write-dst (~ oprand 0) d condition type env)]

       ["sqrt"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define d (sqrt a))
        (write-dst (~ oprand 0) d condition type env)]

       ["abs"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))

        (define fn
          (match type
            [".f16x2" (error-f16x2)]

            [(regexp "^\\.f") abs]

            [(regexp "^\\.s") (lambda (x) (bvsmax a (bvneg a)))]))

        (define d (fn a))
        (write-dst (~ oprand 0) d condition type env)]

       ["bfe"
        #f
        ]

       ["bfi"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 1) type env))
        (define c (read-src (~ oprand 1) ".u32" env))
        (define d (read-src (~ oprand 1) ".u32" env))
        #;(define f b)
        #;(write-dst (~ oprand 0) f condition type env)
        #f]

       [(or "and" "or" "xor" "rem")
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 2) type env))

        (define fn
          (match opcode
            ["and" bvand]
            ["or"  bvor]
            ["xor" bvxor]
            ["rem"
             (match type
               [(regexp "^\\.s") bvsrem]

               [(regexp "^\\.u") bvurem])]))

        (define d (fn a b))
        (write-dst (~ oprand 0) d condition type env)]

       ["not"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define d (bvnot a))
        (write-dst (~ oprand 0) d condition type env)]

       ["setp"
        (define cmpop (~ spec 0))
        (define type (last spec))
        (define fn (select-cmpop cmpop type))

        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 2) type env))
        (define t (make-pred (fn a b)))

        (define p t)
        (define q (bvnot t))

        ;; c
        (when (= (length oprand) 4)
          (define boolop (~ spec 1))
          (define c (read-src (~ oprand 3) type env))
          (define (pred x)
            (match boolop
              [".and" (bvand x c)]

              [".or"  (bvor  x c)]

              [".xor" (bvxor x c)]))
          (set! p (pred p))
          (set! q (pred q)))

        (define-values (dst0 dst1) (pair-dst (~ oprand 0)))

        (write-dst dst0 p condition ".pred" env)
        (when dst1
          (write-dst dst1 q condition ".pred" env))]

       ["set"
        (define cmpop (~ spec 0))
        (define stype (last spec))
        (define dtype (car (take-right spec 2)))
        (unless (type->bit dtype)
          (define tmp cmpop)
          (set! cmpop dtype)
          (set! dtype tmp))
        (define fn (select-cmpop cmpop stype))

        (define a (read-src (~ oprand 1) stype env))
        (define b (read-src (~ oprand 2) stype env))
        (define t (make-pred (fn a b)))

        (define d t)

        ;; c
        (when (= (length oprand) 4)
          (define boolop (~ spec 1))
          (define c (read-src (~ oprand 3) ".pred" env))
          (define (pred x)
            (match boolop
              [".and" (bvand x c)]

              [".or"  (bvor  x c)]

              [".xor" (bvxor x c)]))
          (set! d (pred d)))

        (set! d
          (match dtype
            [".f32" (if (bvzero? d) 0 1.0)]

            [else (if (bvzero? d) (bv #x0 32) (bvnot (bv #x0 32)) )]))

        (write-dst (~ oprand 0) d condition dtype env)]

       ["selp"
        (define type (last spec))
        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 2) type env))
        (define c (read-src (~ oprand 3) ".pred" env))
        (define d (if (not (bvzero? c)) a b))
        (write-dst (~ oprand 0) d condition type env)]

       [(or "shl" "shr")
        (define type (last spec))
        (define bit (type->bit type))
        (define a (read-src (~ oprand 1) type env))
        (define b (read-src (~ oprand 2) ".u32" env))
        (define fn
          (match opcode
            ["shl" bvshl]
            ["shr" bvlshr]))
        (define d (fn a (match bit
                          [16 (extract 15 0 b)]
                          [32 b]
                          [64 (zero-extend b (bitvector 64))])))
        (write-dst (~ oprand 0) d condition type env)]

       ["atom"
        (define type (last spec))
        (define space (address-space spec))
        (define d (load-mem (~ oprand 1) space type env accum x))
        (define *a d)
        (define b #f)
        (define c #f)
        (write-dst (~ oprand 0) d condition type env)

        (set! b (read-src (~ oprand 2) type env))

        ;; todo: st check
        #;(define fn
            (match (atom-op spec)
              [".cas"  ]

              [a (error (format "Unsupported atomic op: ~a" a))]))]

       ["shfl" #f]

       ["bar" #f]

       ["bra"
        (when (condition)
          (accum (cons (list 'cond
                             (condition)
                             (assoc-ref (env) "_cond_name")
                             (assoc-ref (env) "_cond_neg"))
                       (accum))))]

       ["ret" #f]

       ["vote" #f]

       ["call"
        (define m (regexp-match #rx"^\\((.*)\\)$" (~ oprand 0)))

        (define d
          (match (and m (~ oprand 1))
            ["omp_get_num_threads"
             (extract 127 96
               (%define-symbolic "%tid"
                                 (spec->symbolic-type '(".v4" ".u32"))))]

            ["omp_get_thread_num"
             (extract 127 96
               (%define-symbolic "%ntid"
                                 (spec->symbolic-type '(".v4" ".u32"))))]

            [else #f]))

        (when d
          (store-mem (format "[~a]" (~ m 1)) d ".param" ".b32" env accum x))]

       [else
        (error (format "Unknown instruction ~a\nEnv: ~a" opcode (env)))]
       )])

  (condition #f))

(define (error-f16x2)
  (error ".f16x2 is not supported"))

(define (select-cmpop cmpop type)
  (define (or-nan? op) (lambda (a b) (or (op a b) (nan? a) (nan? b))))
  (match type
    [".f16x2" (error-f16x2)]

    [(regexp "^\\.f") ; float
     (match cmpop
       [".eq" =]
       [".ne" (negate =)]
       [".lt" <]
       [".le" <=]
       [".gt" >]
       [".ge" >=]
       [".equ" (or-nan? =)]
       [".neu" (or-nan? (negate bveq))]
       [".ltu" (or-nan? <)]
       [".leu" (or-nan? <=)]
       [".gtu" (or-nan? >)]
       [".geu" (or-nan? >=)]
       [".num" (lambda (a b) (and (not (nan? a)) (not (nan? b))))]
       [".nan" (lambda (a b) (or (nan? a) (nan? b)))]
       [else (error (format "Invalid op for ~a: ~a" type cmpop))])]

    [else
     (match cmpop
       [".eq" bveq]
       [".ne" (negate bveq)]
       [".lt" bvslt]
       [".le" bvsle]
       [".gt" bvsgt]
       [".ge" bvsge]
       [".lo" bvult]
       [".ls" bvult]
       [".hi" bvugt]
       [".hs" bvuge]
       [else (error (format "Invalid op for ~a: ~a" type cmpop))])]))

(define (extract-iterators loop-span cfg)
  (append-map
   (lambda (x)
     (append-map extract-destination-registers
                 (dig (lambda (x) (and (pair? x) (eq? (car x) 'instruction)))
                      (assoc x cfg))))
   loop-span))

(define (add-top-label stmt)
  (match stmt
    [(list (regexp #rx":$") _ ...) stmt]

    [else (cons "TOP_:" stmt)]))

(define (split-at-label stmt)
  ;; todo: jump from nested group, .branchtargets
  (match stmt
    [(list (and label0 (regexp #rx":$")) a ...
           (and label1 (regexp #rx":$")) b ...)
     (append
      (split-at-label (cons label0 a))
      (split-at-label (cons label1 b)))]

    [else (list stmt)]))

(define (split-at-jump stmt)
  (match stmt
    [(list (and label0 (regexp #rx":$")) a ...
           (and b (list 'instruction "bra" _ ...))
           c ..1)
     (append
      (split-at-jump `(,label0 ,@a ,b))
      (split-at-jump c))]

    [else (list stmt)]))

(define (label? x)
  (and (string? x)
       (regexp-match #rx":$" x)))

(define (add-succeeding-label segments [proceeding-label #f])
  (cond [(null? segments) '()]

        [(label? (caar segments))
         (cons (car segments)
               (add-succeeding-label (cdr segments) (caar segments)))]

        [else
         (define label (string-append "cont_" proceeding-label))
         (cons (cons label (car segments))
               (add-succeeding-label (cdr segments) label))]))

;; ((label goto0 goto1 stmt ...) ...)
(define (add-destination segments)
  (if (null? segments) '(("END_:" #f #f))

      (let ()
        (define stmt (car segments))
        (define label (car stmt))
        (define next-label (if (pair? (cdr segments))
                               (caadr segments) "END_:"))

        (define destined
          (match stmt
            [(list _ ...
                   (regexp #rx"^@")
                   (list 'instruction "bra" _ ... goto))
             `(,label ,next-label ,(string-append goto ":") ,@(cdr stmt))]

            [(list _ ...
                   (list 'instruction "bra" _ ... goto))
             `(,label #f ,(string-append goto ":") ,@(cdr stmt))]

            [(list _ ...
                   (not (regexp #rx"^@"))
                   (list 'instruction "ret" _ ...))
             `(,label #f "END_:" ,@(cdr stmt))]

            [(list _ ...
                   (regexp #rx"^@")
                   (list 'instruction "ret" _ ...))
             `(,label ,next-label "END_:" ,@(cdr stmt))]

            [else
             `(,label ,next-label #f ,@(cdr stmt))]))

        (cons destined (add-destination (cdr segments)))
        )))

(define (extract-cfg stmt)
  (cfg-optimize
   (add-destination
    (add-succeeding-label
     (append-map split-at-jump (split-at-label (add-top-label stmt)))))))

(define (cfg-reversed-mapping cfg)
  ;; ((dst src) ...)
  (define rev
    (append-map
     (lambda (x) (list (list (~ x 1) (~ x 0))
                       (list (~ x 2) (~ x 0))))
     cfg))

  ;; ( ( (dst0 src0) (dst0 src1) ...) ...)
  (define g (group-by car rev))

  ;; ( (dst0 src0 src1 ...) ...)
  (filter-map
   (lambda (x) (and (caar x)
                    (cons (caar x)
                          (delete-duplicates (map cadr x)))))
   g))

;; Extract a mapping '(( load-hash . loop-head-hash ) ..) to put initializers
(define (init-pos cfg loops)
  ;; find loads
  (define loads
    (dig (lambda (x) (and (pair? x)
                          (eq? (car x) 'instruction)
                          (equal? (cadr x) "ld"))) cfg))

  ;; from the shorter ones
  (set! loops (sort loops #:key length <))

  ;; iterators always contain variables changing in the loops
  (define iterators
    (map (lambda (l) (cons l (extract-iterators l cfg))) loops))

  ;; find the shortest loop that contains and affects the concerned loads
  (define r
    (map (lambda (ld)
           (cons (eq-hash-code ld)
                 (any
                  (lambda (lo)
                    (and
                     ;; ld contained by loops?
                     (loop-contains? ld lo cfg)
                     ;; index has any iterator in the loops?
                     (pair?
                      (lset-intersection equal?
                       (extract-index-variables (last ld))
                       (assoc-ref iterators lo)))
                     ;; retrieve the hash of the first statement
                     (eq-hash-code (fetch-first-statement cfg lo))))
                  loops)))
         loads))

  r)

(define (loop-contains? a loop-span cfg)
  (any
   (lambda (x) (dig (curry equal? a) (assoc x cfg)))
   loop-span))

(define (fetch-first-statement cfg loop-span)
  (any
   (lambda (s)
     (define d (dig (lambda (x) (and (pair? x) (eq? (car x) 'instruction)))
                    (assoc s cfg)))
     (and (pair? d) (car d)))
   loop-span))

;; Eliminate unnecessary instructions
(define (cfg-optimize cfg)
  (define reversed-mapping (cfg-reversed-mapping cfg))

  ;; label -> dep
  (define deps '())

  ;; insn hash
  (define used '())

  ;; for not tracking unnecessary predictes
  (define used-one-before #f)

  (define (add-used! x)
    (set! used (lset-adjoin equal? used (eq-hash-code x))))

  (define (update! x out)

    (match x
      [(regexp #rx"^@")
       (add-used! x)
       (if used-one-before
           (let ([m (regexp-match #rx"^@(!)?(.*)$" x)])
             (lset-adjoin equal? out (~ m 2)))
           out)]

      [(list 'instruction "st"
             (and opt (regexp #rx"^[.]")) ... a b)
       (set! used-one-before #t)
       (add-used! x)
       (define v (extract-index-variables a))
       (lset-union equal? out v)]

      [(list 'instruction "ld"
             (and opt (regexp #rx"^[.]")) ... d a)
       (set! used-one-before #t)
       (add-used! x)
       (define v (extract-index-variables a))
       (lset-union equal? out v)]

      [(list 'instruction "atom"
             (and opt (regexp #rx"^[.]")) ... oprand ...)
       (add-used! x)
       (update! `(instruction "ld" ,(~ oprand 0) ,(~ oprand 1)) out)]

      [(list 'instruction (or "bra" "ret") _ ...)
       (set! used-one-before #t)
       (add-used! x)
       out]

      [(list 'instruction opcode _ ...)
       (define dst (extract-destination-registers x))
       (if (not (any (curryr member out) dst))
           (let ()
             (set! used-one-before #f)
             out)
           (let ()
             (set! used-one-before #t)
             (add-used! x)
             (lset-union equal? out (extract-source-registers x))))]

      [(list 'group stmt ...)
       (fold update! out (reverse stmt))]

      [(list 'debugging ".section" name grp)
       (fold update! out (reverse (cdr grp)))]

      [else out]))

  (define (backtrace label out)
    ;; if out contains elements not in deps
    (define pre (assoc-ref deps label))
    (define dep (if pre (lset-difference equal? out pre) out))

    (unless (null? dep)
      (define new-pre (append dep (or pre '())))
      (set! deps (assoc-adjoin deps label new-pre))

      ;; new-out
      (match-let ([(list _ _ _ stmt ...) (assoc label cfg)])
        (define new-out (fold update! out (reverse stmt)))

        (define src (assoc-ref reversed-mapping label))
        (when src
          (map (curryr backtrace new-out) src)))))

  (backtrace "END_:" '("NONE"))

  (map (lambda (x) (append (take x 3) (stmt-reduce (drop x 3) used))) cfg))

(define (stmt-reduce cfg used)
  (define r (reverse cfg))
  (define next #f)
  (reverse
   (filter-map
    (lambda (x)
      (match x
        [(regexp #rx"^@") (and next x)]

        [(list 'instruction _ ...)
         (define r (and (member (eq-hash-code x) used) x))
         (set! next r)
         r]

        [(list 'group stmt ...)
         (cons 'group (stmt-reduce stmt used))]

        [(list 'debugging ".section" name grp)
         `('group ,(stmt-reduce (cdr grp) used))]

        [(list 'debugging _ ...) #f]

        [else x]))
    r)))

(define (decompose-oprand oprand)
  (match oprand
    [(regexp #rx"^\\[.*\\]$") '()]

    [(regexp #rx"^\\{.*\\}$")
     (string-split oprand #rx"(\\{|,|\\})")]

    [(regexp #rx"\\|")
     (string-split oprand "|")]

    [else (list oprand)]))

(define (extract-index-variables addr)
  (define m (regexp-match "^\\[([^+]*)(\\+(.*))?\\]$" addr))
  (if (and m (not (constant? (~ m 1)))) (list (~ m 1)) '()))

(define (constant? x)
  (read-constant x ".s64"))

(define (extract-source-registers insn)
  (match insn
    [(list 'instruction opcode
           (and opt (regexp #rx"^[.]")) ...
           (and oprand (regexp #rx"^[^.]")) ..2)
     (filter (negate constant?) (append-map decompose-oprand (cdr oprand)))]))

(define (extract-destination-registers insn)
  (match insn
    [(list 'instruction "call" (regexp #rx"^\\((.*)\\)$" (list _ dst)) _ ...)
     (list dst)]

    [(list 'instruction opcode
           (and opt (regexp #rx"^[.]")) ...
           (and oprand (regexp #rx"^[^.]")) ..2)
     (filter (negate constant?) (decompose-oprand (car oprand)))]

    [else '()]))

;; Get loop headers including nested ones with inner blocks
;; '((loop-header block-in-loop ..) ..)
(define (extract-loops cfg)
  (define loop-span '())
  (define branch-mapping (map (curryr take 3) cfg))
  (define top (caar cfg))

  (define (dest x)
    (filter values (assoc-ref branch-mapping x)))

  ;; label -> successors
  (define deps '())

  (define (traverse proceeding)
    (define label (car proceeding))
    (define pre (assoc-ref deps label))
    (define dep (if pre (lset-difference equal? proceeding pre) proceeding))

    ;; dep for pruning
    (unless (null? dep)
      (define new-pre (append dep (or pre '())))
      (set! deps (assoc-adjoin deps label new-pre))

      (for ([next (dest label)] #:when next)
        (define index (index-of proceeding next))

        (if index
            (set! loop-span
                  (cons (reverse (take proceeding (+ index 1))) loop-span))
            (traverse (cons next new-pre))))))

  (traverse (list top))

  (map
   (lambda (x)
     (cons (caar x) (delete-duplicates (append-map cdr x))))
   (group-by car loop-span)))

(module+ test
  (require rackunit rackunit/text-ui)
  (define-syntax ==
    (syntax-rules ()
      [(_ val ...) (check-equal? val ...)]))

  ;; Debug
  (define emures
    ;(emulate ptx-sample11-out)
    (emulate (parse-ptx ptx-sample13))
    )

  ;; assuming store, then, verify assumption
  (define-symbolic a b (bitvector 32))
  (define ld1 (load32 addr-global a))
  (define ld2 (load32 addr-global (bvadd a (bv 1 32))))
  (define st (bveq (load32 addr-global a) (bv 10 32)))
  (== (unsat) (verify (begin (assume st) (assert (bitvector->bool ld1)))))
  (== (equal?
       (unsat)
       (verify (begin (assume st) (assert (bitvector->bool ld2)))))
      #f)

  (== (addr=? a (bvadd a (bv 1 32))) #f)
  (== (addr=? a a) #t)
  (== (addr=? a b) #f)
  (== (addr=? (bvadd a (load32 addr-global a))
              (bvadd b (load32 addr-global b))) #f)
  (== (addr=? (bvadd a (load32 addr-global b))
              (bvadd b (load32 addr-global b))) #t)
  (define %tid1
    (%define-symbolic "%tid" (spec->symbolic-type '(".v4" ".u32"))))
  (define %tid2
    (%define-symbolic "%tid" (spec->symbolic-type '(".v4" ".u32"))))
  (== (addr=? (bvadd (extract 31 0 %tid1) (load32 addr-global a))
              (bvadd (extract 31 0 %tid2) (load32 addr-global b))) #f)

  (define ld3 (load32 addr-shared ld2))
  (== (find-load ld3 addr-global) (list (bvadd (bv #x01 32) a)))

  (run-tests
   (test-suite "emulate"
    (test-case "constructing cfg"
      (== (add-top-label '("LABEL:" a b))
          '("LABEL:" a b))
      (== (add-top-label '(a b))
          '("TOP_:" a b))

      (== (split-at-label '("LABEL0:" a b))
          '(("LABEL0:" a b)))
      (== (split-at-label '("LABEL0:" a b "LABEL1:" c d))
          '(("LABEL0:" a b) ("LABEL1:" c d)))

      (== (split-at-jump '("LABEL0:" a b
                                     (instruction "bra" ".uni" "LABEL_X")))
          '(("LABEL0:" a b
                       (instruction "bra" ".uni" "LABEL_X"))))
      (== (split-at-jump '("LABEL0:" a b
                                     (instruction "bra" ".uni" "LABEL_X")
                                     c d))
          '(("LABEL0:" a b
                       (instruction "bra" ".uni" "LABEL_X"))
            (c d)))

      (== (add-succeeding-label
           '(("LABEL0:" a b)
             (c d)
             (e f)
             ("LABEL1:" g h)))
          '(("LABEL0:" a b)
            ("cont_LABEL0:" c d)
            ("cont_cont_LABEL0:" e f)
            ("LABEL1:" g h)))

      (== (add-destination
           '(("LABEL0:" a b (instruction "bra" ".uni" "LABEL_X"))
             ("cont_LABEL0:" c d)
             ("cont_cont_LABEL0:"
              e f "@%p1" (instruction "bra" ".uni" "LABEL_Y"))
             ("LABEL1:" g h)))
          '(("LABEL0:" #f "LABEL_X:" a b (instruction "bra" ".uni" "LABEL_X"))
            ("cont_LABEL0:" "cont_cont_LABEL0:" #f c d)
            ("cont_cont_LABEL0:" "LABEL1:" "LABEL_Y:" e f "@%p1"
                                 (instruction "bra" ".uni" "LABEL_Y"))
            ("LABEL1:" "END_:" #f g h)
            ("END_:" #f #f)))

      (== (extract-destination-registers
           '(instruction "mov" ".u32" "%r1" "%tid.x"))
          '("%r1"))
      (== (extract-destination-registers
           '(instruction "mov" ".b64" "{%r679,%r680}" "%r670"))
          '("%r679" "%r680"))
      (== (extract-destination-registers
           '(instruction "mov" ".b64" "{%r679,%r680}" "%r670"))
          '("%r679" "%r680"))
      (== (extract-destination-registers
           '(instruction "setp" ".lt" ".s32" "p|q" "a" "b"))
           '("p" "q"))
      (== (extract-destination-registers
           '(instruction "st" ".param" ".u64" "[%out_arg1]" "%r28"))
           '())
      (== (extract-destination-registers
           '(instruction "call" "(%value_in)" "omp_get_thread_num"))
           '("%value_in"))

      (define cfg1
        '(("A" "B" "C" x y)
          ("B" "B" "B")
          ("C" "D" "E")
          ("D" "D" "A")
          ("E" #f #f)))

      (== (cfg-reversed-mapping cfg1)
          '(("B" "A" "B") ("C" "A") ("D" "C" "D") ("E" "C") ("A" "D")))

      (== (extract-cfg (cddr ptx-sample1-out))
          '(("TOP_:" "cont_TOP_:" "$L13:"
             (storage ".param" ".u64" "%in_ar0")
             (storageN ".reg" ".u64" "%ar0")
             (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
             (storageN ".reg" ".u64" "%r22")
             (storageN ".reg" ".u32" "%r23")
             (storageN ".reg" ".f64" "%r24")
             (storageN ".reg" ".u64" "%r25")
             (storageN ".reg" ".u64" "%r26")
             (storageN ".reg" ".u64" "%r30")
             (storageN ".reg" ".f64" "%r31")
             (storageN ".reg" ".f64" "%r32")
             (storageN ".reg" ".u64" "%r33")
             (storageN ".reg" ".pred" "%r34")
             (storageN ".reg" ".pred" "%r35")
             (storageN ".reg" ".pred" "%r36")
             (group
              (storageN ".reg" ".u32" "%x")
              (instruction "mov" ".u32" "%x" "%tid.x")
              (instruction "setp" ".ne" ".u32" "%r36" "%x" "0"))
             "@%r36"
             (instruction "bra" "$L13"))
            ("cont_TOP_:" #f "$L8:"
             (instruction "mov" ".u64" "%r30" "%ar0")
             (instruction "ld" ".u64" "%r22" "[%r30]")
             (instruction "mov" ".u32" "%r23" "10000")
             (instruction "bra" "$L8"))
            ("$L9:" "$L13:" "$L9:"
             (instruction "mov" ".u64" "%r25" "%r26")
             (instruction "atom" ".cas" ".b64" "%r26" "[%r22]" "%r26" "%r33")
             (instruction "setp" ".ne" ".u64" "%r34" "%r25" "%r26")
             "@%r34"
             (instruction "bra" "$L9"))
            ("$L13:" #f "$L12:"
             (instruction "bra" "$L12"))
            ("$L8:" "cont_$L8:" "$L8:"
             (instruction "add" ".u32" "%r23" "%r23" "-1")
             (instruction "setp" ".ne" ".u32" "%r35" "%r23" "0")
             "@%r35"
             (instruction "bra" "$L8"))
            ("cont_$L8:" #f "$L9:"
             (instruction "mov" ".u64" "%r26" "0")
             (instruction "bra" "$L9"))
            ("$L12:" #f "END_:"
             (instruction "ret"))
            ("END_:" #f #f)))

      (== (extract-cfg
           '((instruction "mov" ".u64" "%r185" "%ar0")
             (instruction "ld" ".u64" "%r186" "[%r185]")
             (instruction "ld" ".u32" "%r27" "[%r186]")
             (instruction "mov" ".u32" "%r90" "%ctaid.x")
             (instruction "add" ".u32" "%r187" "%r27" "192")
             (instruction "div" ".s32" "%r84" "%r187" "192")))
          '(("TOP_:" "END_:" #f
             (instruction "mov" ".u64" "%r185" "%ar0")
             (instruction "ld" ".u64" "%r186" "[%r185]")
             (instruction "ld" ".u32" "%r27" "[%r186]"))
            ("END_:" #f #f)))

      (== (extract-loops cfg1)
          '(("A" "C" "D") ("D") ("B")))

      (define cfg2
        '(("A" "B" "C" x y)
          ("B" "B" "A")
          ("C" "D" "E")
          ("D" "D" "A")
          ("E" #f #f)))

      (== (extract-loops cfg2)
          '(("A" "C" "D" "B") ("D") ("B")))

      (== (extract-iterators
           '("A" "C" "D")
           '(("A" #f #f (instruction "mov" ".u32" "%r1" "%tid.x"))
             ("B" #f #f (instruction "mov" ".u32" "%r2" "%tid.x"))
             ("C" #f #f (instruction "mov" ".u32" "%r3" "%tid.x"))
             ("D" #f #f (instruction "mov" ".u32" "%r4" "%tid.x"))
             ("E" #f #f (instruction "mov" ".u32" "%r5" "%tid.x"))))
          '("%r1" "%r3" "%r4"))
      )

    (test-case "read & write"
      (== (read-constant "301" ".b32") (bv #x0000012d 32))
      (== (read-constant "-8589934592" ".s64")
          (bv #xfffffffe00000000 64))
      (== (read-constant "0b1" ".pred") (bv #b1 1))
      (== (read-constant "010" ".b8") (bv #x08 8))
      (== (read-constant "0x10" ".b8") (bv #x10 8))
      (== (read-constant "-1.2" ".f16") -1.2)
      (== (read-constant "0f40400000" ".f32")
          (floating-point-bytes->real #"\x40\x40\x00\x00" #t))
      (== (read-constant "0F3f800000" ".f32") 1.0)

      (== (read-addr "omptarget_nvptx_globalArgs+20" ".b64")
          (bvadd (bv #x00000014 64)
           (%define-symbolic "omptarget_nvptx_globalArgs" (bitvector 64))))

      (== (vec-ref (bv #x00989680 32) ".x" 2)
          (bv #x0098 16))
      (== (vec-ref (bv #x00989680 32) ".y" 2)
          (bv #x9680 16))
      (== (vec-ref (bv #x1122334455667788 64) ".b" 4)
          (bv #x5566 16))
      (== (vec-ref (bv #x12345678 32) ".x" 4)
          (bv #x12 8))
      (== (vec-ref (bv #x12345678 32) ".y" 4)
          (bv #x34 8))
      (== (vec-ref (bv #x12345678 32) ".z" 4)
          (bv #x56 8))
      (== (vec-ref (bv #x12345678 32) ".w" 4)
          (bv #x78 8))

      (== (bv-size (bv 0 32)) 32)
      (== (bv-size (bv 0 128)) 128)

      (== (type-downsize ".u16" 2) ".u8")
      (== (type-downsize ".b64" 4) ".b16")

      (define env (make-parameter '()))
      (define-symbolic* r (bitvector 1))
      (env `(("%r" . ,r)))
      (clear-terms!)

      (typeinfo-add "%r" '(".pred"))
      (== (read-reg "%r" ".pred" env) r)
      (env (acons "%r" (bv #x12345678 32) '()))
      (typeinfo-add "%r" '(".v2" ".u16"))
      (== (read-reg "%r.y" ".u16" env) (bv #x5678 16))

      (== (read-vec "{%r.x,%r.y}" ".u32" env) (bv #x12345678 32))

      (== (bitvector-split (bv #x12345678 32) 4)
          (list (bv #x12 8) (bv #x34 8) (bv #x56 8) (bv #x78 8)))

      (== (vec-update (bv #x00989680 32) (bv #xAAAA 16) ".x" 2)
          (bv #xAAAA9680 32))
      (== (vec-update (bv #x00989680 32) (bv #xBBBB 16) ".y" 2)
          (bv #x0098BBBB 32))
      (== (vec-update (bv #x1122334455667788 64) (bv #xCCCC 16) ".b" 4)
          (bv #x11223344CCCC7788 64))
      (== (vec-update (bv #x12345678 32) (bv #xDD 8) ".x" 4)
          (bv #xDD345678 32))
      (== (vec-update (bv #x12345678 32) (bv #xEE 8) ".y" 4)
          (bv #x12EE5678 32))
      (== (vec-update (bv #x12345678 32) (bv #xFF 8) ".z" 4)
          (bv #x1234FF78 32))
      (== (vec-update (bv #x12345678 32) (bv #x00 8) ".w" 4)
          (bv #x12345600 32))

      (define-symbolic* a (bitvector 32))
      (define-symbolic* p (bitvector 1))
      (define condition (make-parameter p))
      (env `(("%a" . ,a)))
      (typeinfo-add "%a" '(".u32"))
      (write-reg "%a" (bv 0 32) condition ".b32" env)
      (== (read-reg "%a" ".b32" env)
          (if (bveq (bv #b0 1) p) a (bv #x00000000 32)))

      (condition #f)
      (typeinfo-add "%a" '(".v2" ".u16"))
      (write-reg "%a.y" (bv #xffff 16) condition ".b16" env)
      (== (read-reg "%a" ".b32" env)
          (concat
           (extract 31 16 (if (bveq (bv #b0 1) p) a (bv #x00000000 32)))
           (bv #xffff 16)))

      (write-vec "{%a.x,%a.y}" (bv #xaaaabbbb 32) condition ".b32" env)
      (== (read-reg "%a" ".b32" env)
          (bv #xaaaabbbb 32))

      )

    (test-case "exec"
      (define condition (make-parameter #f))
      (define env (make-parameter '()))
      (define accum (make-parameter '()))
      (define-symbolic* r (bitvector 1))
      (clear-terms!)

      (env `(("%r" . ,r)))
      (exec "@%r" condition env accum)
      (== (condition) r)
      (exec "@!%r" condition env accum)
      (== (condition) (bvnot r))

      (env '())
      (exec '(storageN ".reg" ".pred" "%p<17>") condition env accum)
      (== (length (env)) 17)
      (== (car (~ (env) 0)) "%p0")
      (== (car (~ (env) 8)) "%p8")
      (== (car (~ (env) 16)) "%p16")
      (== (type-of (cdr (~ (env) 16))) (bitvector 1))
      (exec '(storageN ".reg" ".u64" "%r22") condition env accum)
      (== (caar (env)) "%r22")
      (== (type-of (cdar (env))) (bitvector 64))
      (exec '(storageN ".reg" ".v2" ".u32" "%r196") condition env accum)
      (== (caar (env)) "%r196")
      (== (type-of (cdar (env))) (bitvector 64))
      (exec '(storageN ".reg" ".f32" "%r287") condition env accum)
      (== (caar (env)) "%r287")
      (== (type-of (cdar (env))) (bitvector 32))

      ;; todo: inst test
      (define top-env '())
      (add-special-regs! top-env %tid '(".v4" ".u32"))
      (define %tid (cdar top-env))
      (env top-env)
      (condition #f)
      (accum '())
      (exec '(storageN ".reg" ".u32" "%x") condition env accum)
      (exec '(instruction "mov" ".u32" "%x" "%tid.x") condition env accum)
      (== (env)
          (list (cons "%x" (extract 127 96 %tid)) (cons "%tid" %tid)))
      )
    )))
