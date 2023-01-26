#lang rosette

(require
 "util.rkt"
 srfi/1
 racket/match)

(provide (all-defined-out))

(define (gen stmt diff init-pos)
  (define shfl-red (contrive-shuffle stmt diff)) ; redundant shuffle
  (define shfl (optimize-shuffle shfl-red diff))
  (print-shuffle-info shfl diff)
  (define src (filter (lambda (x) (eq? (cadr x) 'src)) shfl))
  (define regs
    (map (lambda (x)
           `(storageN ".reg" ,(~ x 2) ,(format "%__pw_~a" (~ x 0))))
         (delete-duplicates src (lambda (a b) (eq? (car a) (car b))))))
  ;(define stmt-inited (put-init stmt init-pos src))
  (define stmt-implanted (implant-shuffle stmt shfl))
  (append
   regs
   '((storageN ".reg" ".u32" "%warp_id")
     (instruction "mov" ".u32" "%warp_id" "%tid.x")
     (instruction "rem" ".u32" "%warp_id" "%warp_id" "32"))
   stmt-implanted))

(define (print-shuffle-info shfl diff)
  (define ll (length diff))
  (define dst (map cddr (filter (lambda (s) (eq? (cadr s) 'dst)) shfl)))
  (define uni (filter (lambda (d) (= (length d) 3)) dst))
  (define sum (apply + (map (compose abs (curryr ~ 2)) dst)))
  (define dl (length dst))
  (define ul (length uni))
  (displayln
   (format "LOAD:~a SHUFFLE:~a AVERAGE:~a POSSIBLE-BIDIR:~a"
           ll
           dl
           (if (= dl 0) #f (~r (/ sum dl) #:precision '(= 2)))
           (- dl ul))
   (current-error-port)))

(define (init-val type)
  (match type
    [(regexp "^\\.[u]") "-1"]
    [(or ".s8" ".b8" ".f8") "0xff"]
    [(or ".s16" ".b16") "0xffff"]
    [(or ".s32" ".b32" ".f16x2") "0xffffffff"]
    [(or ".b64" ".b64") "0xffffffffffffffff"]
    [".f32" "0fffffffff"]
    [".f64" "0dffffffffffffffff"]
    [".pred" "0b1"]
    [else #f]))

;; Put initialization on the top of innermost loops
;; (no need to initialize loads outside loops)
(define (put-init s init-pos src)
  (match s
    [(list 'group _ ...)
     `(group ,@(put-init (cdr s) init-pos src))]

    [(list 'instruction _ ...)
     (define h (eq-hash-code s))
     (define v (filter-map
                (lambda (x) (and (eq? h (cdr x))
                                 (and-let1 info (assoc-ref src (car x))
                                   (cons (car x) (~ info 1)) ; (hash . type)
                                   )))
                init-pos))

     (if (null? v) s
         `(group
           ,@(map (lambda (x)
                    `(instruction "mov" ,(cdr x) ,(format "%__pw_~a" (car x))
                                  ,(init-val (cdr x))))
                  v)
           ,s))]

    [(list 'debugging _ ...)
     (match (~ s 1)
       [(or ".file" ".loc") s]

       [".section"
        (list 'debugging ".section" (~ s 2) (put-init (~ s 3) init-pos src))])]

    [(list _ ...)
     (map (curryr put-init init-pos src) s)]

    [else s]))

;; Avoid redudant shuffles (shuffle over shuffle) & find bi-directional shuffles
(define (optimize-shuffle orig diff)
  (define r (map car orig)) ; hashes of redundant shuffle
  (append-map (lambda (o) (optimize-shuffle1 (~ o 0) (~ o 1) r diff)) orig))

(define (optimize-shuffle1 h i r diff) ; hash instruction redundant diff
  (define x (assoc-ref diff h))
  (define v (and x (filter cdr x)))
  (define s (and v (sort v #:key cdr (lambda (a b) (< (abs a) (abs b))))))
  (define unique? (compose null? cdr delete-duplicates))
  (define not-in-r (negate (compose (curryr member r) caar)))
  (define pred (conjoin not-in-r unique?))
  ;(define pred unique?) ; For bi-directional
  (define same-hash (lambda (e) (filter (lambda (a) (= (car e) (car a))) x)))
  (define f (and (pair? s) (filter (compose pred same-hash) s)))
  (define c (and (pair? f) (car f)))
  (define type (and c
                (match (cdr i)
                  [(list opcode (and spec (regexp #rx"^[.]")) ... oprand ...)
                   (last spec)])))
  (define b ; bi-directional
    (and c (not (= (cdr c) 0))
         (findf (lambda (e)
                  (define we (cdr e)) (define wc (cdr c))
                  (cond [(and (> we 0) (> wc 0)) #f]
                        [(and (< we 0) (< wc 0)) #f]
                        [(<= (+ (abs we) (abs wc)) 32) e]
                        [else #f]))
                f)))

  (define src
    `(,@(if (not c) '()
            ;; hash 'src type dst-hash width
            (list (list (car c) 'src type h (cdr c)) ))
      ,@(if (not b) '()
            (list (list (car b) 'src type h (cdr b)) ))))

  (define dst
    `(,@(if (not c) '()
            ; hash 'dst type src-hash width [bi-directional-hash width]
            (list `(,h dst ,type ,(car c) ,(cdr c)
                       ,@(if (not b) '() (list (car b) (cdr b)))
                       )))))

  (append src dst))

(define (contrive-shuffle stmt diff)
  (append-map (curryr contrive1 diff) stmt))

(define (contrive1 s diff)
  (match s
    [(list 'group _ ...)
     (contrive-shuffle (cdr s) diff)]

    [(list 'instruction _ ...)
     (contrive-insn s diff)]

    [(list 'debugging _ ...)
     (match (~ s 1)
       [(or ".file" ".loc") '()]

       [".section"
        (contrive1 (~ s 3) diff)])]

    [else '()]))

(define (contrive-insn i diff)
  (define h (eq-hash-code i))
  (define x (assoc-ref diff h))
  (define v (and x (filter cdr x)))
  (define s (and v (sort v #:key cdr (lambda (a b) (< (abs a) (abs b))) )))
  ;; if the shuffle size is consistent
  (define unique? (compose null? cdr delete-duplicates))
  (define same-hash (lambda (e) (filter (lambda (a) (= (car e) (car a))) x)))
  (define c (and (pair? s) (findf (compose unique? same-hash) s)))
  (define type (and c
                (match (cdr i)
                  [(list opcode (and spec (regexp #rx"^[.]")) ... oprand ...)
                   (last spec)])))
  (if c
      ;; (list (list (car m) 'src type h (cdr m)) ; hash 'src type dst-hash width
      ;;       (list h 'dst type (car m) (cdr m))); hash 'dst type src-hash width
      (list (list h i))
      '()))

(define (implant-shuffle stmt shfl)
  (map (curryr implant1 shfl) stmt))

(define (implant1 s shfl)
  (match s
    [(list 'group _ ...)
     `(group ,@(implant-shuffle (cdr s) shfl))]

    [(list 'instruction _ ...)
     (implant-insn s shfl)]

    [(list 'debugging _ ...)
     (match (~ s 1)
       [(or ".file" ".loc") s]

       [".section"
        (list 'debugging ".section" (~ s 2) (implant1 (~ s 3) shfl))])]

    [else s]))

(define (implant-insn i shfl)
  (define h (eq-hash-code i))
  (define t (map cdr (filter (lambda (s) (= h (car s))) shfl)))
  (define s (assoc-ref t 'src))
  (define d (assoc-ref t 'dst))
  (define r (and (or s d)
                 (match (cdr i)
                   [(list opcode (and spec (regexp #rx"^[.]")) ... oprand ...)
                    (car oprand)])))

  (define si (and s `(instruction "mov" ,(~ s 0) ,(format "%__pw_~a" h) ,r)))

  (define type (and d (~ d 0)))

  (define temp (and d (format "%__pw_~a" (~ d 1) )))

  (define width (and d (~ d 2)))

  (define init (init-val type))

  (define pred (format "%__pw_~a_p" h))

  (define pred2 (format "%__pw_~a_p2" h))
  (define pred3 (format "%__pw_~a_p3" h))

  (define mask (format "%__pw_~a_m" h))

  (define tmp0 (format "%__pw_~a_t0" h))
  (define tmp1 (format "%__pw_~a_t1" h))

  (define laneidx "%warp_id")

  (define diN
    (and d
         (list
          `(storageN ".reg" ".pred" ,pred)
          `(storageN ".reg" ".pred" ,pred2)
          `(storageN ".reg" ".pred" ,pred3)
          `(storageN ".reg" ".u32" ,mask)
          `(storageN ".reg" ,type ,tmp0)
          `(storageN ".reg" ,type ,tmp1)
          `(instruction "activemask" ".b32" ,mask)
          `(instruction "setp" ".ne" ".s32" ,pred ,mask "-1")
          (if (< width 0)
              `(instruction "setp" ".lt" ".u32"
                            ,pred2 ,laneidx
                            ,(number->string (abs width)))
              `(instruction "setp" ".gt" ".u32"
                            ,pred2 ,laneidx
                            ,(number->string (- 31 (abs width)))))
          `(instruction "or" ".pred" ,pred3 ,pred ,pred2)

          (if (getenv "PW_NOLOAD")
              `(instruction "mov" ".b32" ,tmp0 ,tmp0)
              `(instruction
                "shfl" ".sync"
                ,(if (< width 0) ".up" ".down") ".b32"
                ,(format "~a|~a" r pred)
                ,temp ,(number->string (abs width))
                ,(if (< width 0) "0" "31") ,mask))

          (format "@~a" pred3)
          (if (or (getenv "PW_NOLOAD") (getenv "PW_NOCORNER"))
              `(instruction "mov" ".b32" ,tmp0 ,tmp0)
              i)
          )))

  ;; ;; Bi-directional (No such case exists if redundant shuffle is eliminated)
  ;; (define b (and d (= (length d) 5)))

  ;; (define b-temp (and b (format "%__pw_~a" (~ d 3) )))

  ;; (define b-width (and b (~ d 4)))

  ;; ;; Too much overhead with the corner case
  ;; (define b-diN
  ;;   (and b
  ;;        (list
  ;;         `(storageN ".reg" ".pred" ,pred)
  ;;         `(storageN ".reg" ".pred" ,pred2)
  ;;         `(storageN ".reg" ".pred" ,pred3)
  ;;         `(storageN ".reg" ".u32" ,mask)
  ;;         `(storageN ".reg" ,type ,tmp0)
  ;;         `(storageN ".reg" ,type ,tmp1)
  ;;         `(storageN ".reg" ".u32" ,laneidx)
  ;;         `(instruction "mov" ".u32" ,laneidx "%tid.x")
  ;;         `(instruction "rem" ".u32" ,laneidx ,laneidx "32")
  ;;         `(instruction "activemask" ".b32" ,mask)
  ;;         `(instruction "setp" ".ne" ".s32" ,pred ,mask "-1")
  ;;         (if (< width 0)
  ;;             `(instruction "setp" ".lt" ".u32"
  ;;                           ,pred2 ,laneidx
  ;;                           ,(number->string (abs width)))
  ;;             `(instruction "setp" ".gt" ".u32"
  ;;                           ,pred2 ,laneidx
  ;;                           ,(number->string (- 31 (abs width)))))
  ;;         `(instruction "or" ".pred" ,pred3 ,pred ,pred2)

  ;;         `(instruction
  ;;           "shfl" ".sync"
  ;;           ,(if (< width 0) ".up" ".down") ".b32"
  ;;           ,(format "~a|~a" r pred)
  ;;           ,temp ,(number->string (abs width))
  ;;           ,(if (< width 0) "0" "31") ,mask)

  ;;         `(instruction
  ;;           "shfl" ".sync"
  ;;           ,(if (< b-width 0) ".up" ".down") ".b32"
  ;;           ,(format "~a|~a" tmp0 pred)
  ;;           ,b-temp ,(number->string (abs b-width))
  ;;           ,(if (< b-width 0) "0" "31") ,mask)

  ;;         (format "@~a" pred2)
  ;;         `(instruction "mov" ,type ,r ,tmp0)

  ;;         (format "@~a" pred) i
  ;;         )))

  (define di0 (and d (list `(instruction "mov" ,type ,r ,temp))))

  (define di (and d (if (= width 0) di0 diN)))
  ;; (define di (cond [(not d) #f] [(= width 0) di0] [b b-diN] [else diN]))

  ;;
  ;; // If src found:
  ;; %__pw_HASH <- dst
  ;;
  ;; // If dst found:
  ;; dst|p = __shfl_(up|down)_sync(__activemask(), %__pw_HASH, Shuffle_Width)
  ;; if (!p || dst == ~0))
  ;;   dst = LD
  ;;
  (cond [(not (or s d)) i]

        [(and s d)
         `(group ,@di ,si)]

        [s `(group ,i ,si)]

        [d `(group ,@di)]))

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "gen"
    (test-case "gen-???"
      (check-equal? (values #t) #t)))
   ))
