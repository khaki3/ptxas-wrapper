#lang racket

(require
 peg
 "util.rkt"
 "ptx-sample.rkt"
 (only-in srfi/1 find)
 (only-in srfi/13 string-contains)
 racket/match)

(provide (all-defined-out))

;; Note for PEG:
;;
;;   - ((+|*|?) a b ..) == ((+|*|?) (and a b ..))
;;
;;   - Repeating rules defined by define-peg/bake makes a list.
;;
;;   - The generated parser will be LL(k) at most
;;      => Avoid putting the (* ..) expression in the middle of rules
;;
;;   - (and (* rule) _) -> often should be (* rule _)
;;
;;   - (define-peg/tag rule (and non-baked-rule (* non-existing-term)))
;;       -> (rule . res)
;;     (define-peg/tag rule baked-rule)
;;       -> (rule . res)
;;     But, (define-peg/tag rule (and baked-rule (* non-existing-term)))
;;       -> (rule res)
;;     To create a proper list, use (name res ..)
;;
;;   - The plain definition without bake/tag indicates the concatenation with
;;     other terms
;;
;;     (and non-baked non-baked baked)
;;       -> '(non-baked(+)non-baked baked)
;;
;;     (* baked-or-tagged1) (* baked-or-tagged2)
;;       -> '(baked-or-tagged1 .. baked-or-tagged2 ..)
;;
;;   - Baking baked rules generates the same ones
;;     ; (define-peg/bake rules baked-or-tagged)
;;
;;

(define-peg ptx-parser (+ _ ptx-top))

(define-peg ptx-top
  (or module
      linking
      (and storageN _ (drop #\;))
      kernel
      function
      debugging
      otherwise
      ))

(define-peg/drop _ (* (or #\space #\newline #\tab)))
(define-peg - (* (or #\space #\tab)))

(define-peg module
  (name res (or (and ".version" - (+ digit) #\. (+ digit))
                (and ".target" - identifier (* - #\, - identifier))
                (and ".address_size" - (or "32" "64"))))
  `(module ,res))

(define-peg otherwise
  (name res (+ (any-char)))
  `(otherwise ,res))

(define-peg digit (range #\0 #\9))

(define-peg alphabet (or (range #\a #\z) (range #\A #\Z)))

(define-peg followsym (or alphabet digit #\_ #\$))

(define-peg identifier (or (and (or #\_ #\$ #\%) (+ followsym))
                           (and alphabet (* followsym))
                           "_"))

(define-peg variable
  (or special-register
      vector-register
      identifier))

(define-peg special-register
  (and (or "%tid"
           "%ntid"
           "%ctaid"
           "%nctaid")
       #\.
       identifier))

(define-peg vector-register
  (and identifier
       (or ".x" ".y" ".z" ".w"
           ".r" ".g" ".b" ".a")))

(define-peg/tag linking
  (and (or ".extern" ".visible" ".weak" ".common") _

       (or (and storageN _ (drop #\;))
           kernel
           function)))

(define-peg/bake storage-spec
  (or ".param" ".ptr"
      ".const" ".global" ".local" ".shared"
      ".reg" ".sreg" ".tex" 
      (and ".align" - constant)
      ".v2" ".v4"
      type-specifiers))

;; UNSUPPORTED:
;; .alias
;; .attribute
;; .managed

(define-peg/tag storage
  (and (+ storage-spec _)
       variable-decl))

(define-peg/tag storageN
  (and (+ storage-spec _)
       (+ (or variable-decl-with-init
              variable-decl) _
          (? (drop #\, _)))))

;; (var init)   ; this parenthesis is necessary for the case: reg = reg
(define-peg variable-decl-with-init
  (name res (and variable-decl _
                 (drop #\=) _ literal))
  res)

;; var
(define-peg/bake variable-decl
  (and variable _
       (or (and #\< _ constant _ #\>)
           (+ #\[ _ (? constant) _ #\] _)
           (epsilon))))

(define-peg type-specifiers
  (or ".s8" ".s16" ".s32" ".s64"
      ".u8" ".u16" ".u32" ".u64"
      ".f8" ".f16x2" ".f32" ".f64"
      ".b8" ".b16" ".b32" ".b64"
      ".pred"))

(define-peg hexdigit (or digit (range #\A #\F) (range #\a #\f)))

;; TODO: partially overlap constant with constant-expr
;;       (e.g. arg of mask, operands, offset of var+offset)
;;       This expression could be optimized away to form a mere constant.
;;       Note: var+offset is a special form, not a constant expression.
;;(define-peg/tag constant-expr ..)

(define-peg constant
  (and
   (? #\-)
   (or
    (and (* digit) #\. (+ digit))
    (and #\0 (or #\f #\F)
         hexdigit hexdigit hexdigit hexdigit
         hexdigit hexdigit hexdigit hexdigit)
    (and #\0 (or #\d #\D)
         hexdigit hexdigit hexdigit hexdigit
         hexdigit hexdigit hexdigit hexdigit
         hexdigit hexdigit hexdigit hexdigit
         hexdigit hexdigit hexdigit hexdigit)
    (and #\0 (or #\x #\X) (+ hexdigit) (? #\U))
    (and #\0 (+ (range #\0 #\7)) (? #\U))
    (and #\0 (or #\b #\B) (+ (or #\0 #\1)) (? #\U))
    (and (range #\1 #\9) (* digit) (? #\U))
    #\0)))

(define-peg/bake constant/b constant)

(define-peg/tag kernel
  (and (drop ".entry") _
       identifier _
       param-list _
       (* tuning)
       (or (drop #\;)
           kernel-body)))

(define-peg function
  (name res
        (and (drop ".func") _
             (? param-list) _
             identifier _
             (? param-list) _
             (? tuning) _
             (or (drop #\;)
                 kernel-body)))
  (if (string? res)
      `(function ,res) ; to generate a proper list
      `(function ,@res)))

(define-peg param-list
  (and
   (drop #\() _
   (* (? (drop #\,)) _
      storage _) _
   (drop #\))))

(define-peg/bake tuning
  (or (and (or ".maxnreg" ".maxntid" ".reqntid"
               ".minnctapersm" ".maxnctapersm" ".noreturn") _
           (* (+ constant/b _ (? (drop #\,)) _)))
      pragma))

(define-peg pragma
  (and ".pragma" _ (name s string) _ (drop #\;))
  `(pragma ,s))

(define-peg kernel-body
  (and
   (drop #\{) _

   (* statement _)

   (drop #\})))

(define-peg statement
  (and (or prototype
           label
           pred
           group
           pragma
           storageN
           instruction
           debugging
           controlflow) _
       (? (drop #\;))
       ))

(define-peg/tag prototype
  ;; In LLVM, calling through prototypes is optimized away except
  ;; the code in __kmpc_kernel_deinit that kills the workers
  ;; Ref: libomptarget/deviceRTLs/nvptx/src/omptarget-nvptx.cu
  (and label _
       (drop ".callprototype") _
       (? param-list) _
       identifier _
       (? (or tuning param-list (epsilon)))))

(define-peg/bake label
  (and identifier _ #\:))

(define-peg/bake pred
  (and #\@ (? #\!) variable))

(define-peg/tag group
  (and (drop #\{) _
       (* statement _)
       (drop #\})))

(define-peg/tag instruction
  (or function-call
      (and opcode _
           (* (or operand-pair
                  operand-brace
                  operand/b) _
              (? (drop #\,)) _)
           )))

(define-peg function-call
  (and (and "call" _ (* opcode-option _)) _
       ;; return
       (? operand-parenthesis _ (drop #\,)) _
       ;; function name or pointer
       operand/b _
       ;; args
       (? (drop #\,) _ operand-parenthesis) _
       ;; prototype
       (? (drop #\,) _ identifier)))

(define-peg opcode
  (and opcode-name _ (* opcode-option _)))

(define-peg/bake opcode-name identifier)

(define-peg/bake opcode-option dot-identifier)

(define-peg/bake dot-identifier (and #\. identifier))

(define-peg/bake operand-pair
  (and operand _ #\| _ operand))

(define-peg/bake operand-brace
  (and #\{ _ (* operand _ (? #\,) _) #\} ))

(define-peg/bake operand-parenthesis
  (and #\( _ (* operand _ (? #\,) _) #\) ))

(define-peg operand
  (or (and variable _ #\+ _ constant) ; var+offset
      variable
      (and #\[ _ (or variable constant) _ (? #\+ _ constant)  #\]) ; +offset
      constant ; todo: const-expr
      ))

(define-peg/bake operand/b
  operand)

(define-peg/bake literal
  (or ;; pointer
      (and "generic(" identifier ")") ; todo: var+offset

      ;; pointer (the same as generic(id))
      ;identifier

      ;; Mask unsupported
      ;(and (or "0xFF" "0xff") (* "00") "(" generic+offset or const-expr ")")

      (and (drop #\{) _ literal _ (* (drop #\,) _ literal _) (drop #\}))

      constant))

(define-peg/bake string
  (and #\" (+ (and (! #\") (any-char))) #\"))

(define-peg/tag debugging
  (or (and ".file" _ constant/b _
           string _
           (* #\, _ constant/b))
      (and ".loc" _ constant/b _ constant/b _ constant/b)
      (and ".section" _ dot-identifier _ group)))

(define-peg/tag controlflow
  (or (and ".branchtargets" _
           (+ identifier _ (drop (? #\,)) _))
      (and ".callprototype"
           (+ "UNSUPPORTED")) ; todo
      (and ".calltargets"
           (+ "UNSUPPORTED")) ; todo
      ))

(define (remove-comments str)
  ;; Slower version
  ;;
  ;; (define-peg comment-remover
  ;;   (* (or (drop (and "/*" (* (and (! "*/") (any-char))) "*/"))
  ;;          (drop (and "//" (* (and (! "\n") (any-char)))))
  ;;          (any-char))))
  ;; (peg comment-remover str)
  ;;
  ;; (regexp-replaces
  ;;  str
  ;;  '[(#rx"/\\*.*?\\*/" "")
  ;;
  ;;    (#rx"//.*?(\n|$)" "\\1")])
  ;;
  (let loop ([lst '()] [str str])
    (define x (string-contains str "/"))
    (define n (and x (+ x 1)))
    (define i (and x (< n (string-length str))))
    (define a (and i (char=? (string-ref str n) #\/)))
    (define b (and i (char=? (string-ref str n) #\*)))
    (define c (and x (substring str n)))

    (cond [(not x)
           (string-join (reverse (cons str lst)) "")]

          [(not (or a b))
           (loop (cons (substring str 0 n) lst) c)]

          [a
           (define y (string-contains c "\n"))
           (loop (cons (substring str 0 x) lst)
                 (if y (substring c y) ""))]

          [b
           (define y (string-contains c "*/"))
           (loop (cons (substring str 0 x) lst)
                 (if y (substring c (+ y 2)) ""))]
          )))

(define (parse-ptx str)
  (peg ptx-parser (remove-comments str)))

(define (ptx-read filename)
  (define ptxasm (parse-ptx (file->string filename)))
  (define err (find (compose1 (curry eq? 'otherwise) car) ptxasm))

  (when err
    (error (format "Unknown term: ~a" (cadr err))))

  ptxasm)

(define (ptxasm-to-str ptxasm)
  (string-join (map top-to-str ptxasm) ""))

(define (top-to-str x)
  (match (car x)
    ['module
     (format "~a\n" (~ x 1))]

    ['linking
     (format "~a ~a" (~ x 1) (top-to-str (~ x 2)))]

    ['debugging
     (debugging-to-str x)]

    ['storageN
     (storageN-to-str x)]

    ['kernel
     (kernel-to-str x)]

    ['function
     (function-to-str x)]))

(define (debugging-to-str x)
  (match (~ x 1)
    [(or ".file" ".loc")
     (string-join (cdr x) " " #:after-last "\n")]

    [".section"
     (format ".section ~a ~a" (~ x 2) (group-to-str (~ x 3)))]))

(define (literal-to-str x)
  (if (string? x) x
      ;; list
      (format "{~a}" (string-join (map literal-to-str x) ","))))

(define (storage-to-str x)
  (match (cdr x)
    [(list (and spec (regexp #rx"^[.]")) ... decl ...)

     (format "~a ~a"
             (string-join spec " ")

             (string-join
              (map
               (lambda (x)
                 (if (string? x) x
                     ;; with init
                     (format "~a = ~a" (~ x 0) (literal-to-str (~ x 1)))))
               decl)
              ", "))]))

(define (storageN-to-str x)
  (format "~a;\n" (storage-to-str x)))

(define (kernel-to-str x)
  (format ".entry ~a" (block-to-str x)))

(define (function-to-str x)
  (format ".func ~a" (block-to-str x)))

(define (block-to-str x)
  (match (cdr x)
    [(list (and r (list 'storage _ ...)) ...
           (and name (? string?))
           (and p (list 'storage _ ...)) ...
           (and t (or (regexp #rx"^[.]")
                      (list (regexp #rx"[.]") _ ...))) ...
           stmt ...)
     (format "~a~a~a~a~a"
             (if (null? r) ""
                 (format "(~a) " (string-join (map storage-to-str r) ", ")))
             (format "~a " name)
             (if (null? p) ""
                 (format "(~a) " (string-join (map storage-to-str p) ", ")))
             (if (null? t) ""
                 (format "~a " (string-join (map tuning-to-str t) " ")))
             (if (null? stmt) ";\n"
                 (group-to-str `(group ,@stmt)))
             )]))

(define (tuning-to-str x)
  (cond [(string? x) x]

        [(eq? (car x) 'pragma)
         (pragma-to-str x)]

        [else
         ;; list
         (format "~a ~a" (car x) (string-join (cdr x) ", "))]))

(define (pragma-to-str x)
  (format ".pragma ~a;" (~ x 1)))

(define (group-to-str x)
  (format "{\n~a}\n" (string-join (map statement-to-str (cdr x)) "")))

(define (statement-to-str x)
  (match x
    [(regexp #rx":$")
     (format "~a\n" x)]

    [(regexp #rx"^@")
     (format "~a " x)]

    [(list 'prototype _ ...)
     (prototype-to-str x)]

    [(list 'pragma _)
     (format "~a\n" (pragma-to-str x))]

    [(list 'storageN _ ...)
     (storageN-to-str x)]

    [(list 'group _ ...)
     (group-to-str x)]

    [(list 'instruction _ ...)
     (instruction-to-str x)]

    [(list 'debugging _ ...)
     (debugging-to-str x)]

    [(list 'controlflow _ ...)
     (error "UNSUPPORTED")]))

(define (prototype-to-str x)
  (match (cddr x)
    [(list (and r (list 'storage _ ...)) ...
           (and name (? string?))
           (and p (list 'storage _ ...)) ...
           (and t (or (regexp #rx"^[.]")
                      (list (regexp #rx"[.]") _ ...))) ...)
     (format "~a .callprototype ~a~a~a~a;\n"
             (~ x 1)
             (if (null? r) ""
                 (format "(~a) " (string-join (map storage-to-str r) ", ")))
             (format "~a " name)
             (if (null? p) ""
                 (format "(~a)" (string-join (map storage-to-str p) ", ")))
             (if (null? t) ""
                 (format "~a" (string-join (map tuning-to-str t) " "))))
     ]))

(define (instruction-to-str x)
  (match (cdr x)
    [(list opcode (and spec (regexp #rx"^[.]")) ... oprand ...)

     (format "~a ~a;\n"
             (string-join (cons opcode spec) "")
             (string-join oprand ", "))]))

(define (ptx-write ptxasm filename)
  (define str (ptxasm-to-str ptxasm))
  ;; GCC holds information with //: lines
  (define meta-info (filter (disjoin
                             ;; gcc: gcc/config/nvptx/mkoffload.c
                             (curry regexp-match #rx"^//:")
                             ;; nvptx-tools: nvptx-ld.c
                             (curry regexp-match #rx"^// BEGIN "))
                            (file->lines filename)))

  (display-to-file str filename #:exists 'replace)
  (display-to-file
   (string-join meta-info "\n" #:after-last "\n") filename #:exists 'append)

  ;; Debug
  #;(display (file->string filename) (current-error-port)))

(module+ test
  (require rackunit rackunit/text-ui)
  (define-syntax ==
    (syntax-rules ()
      [(_ val ...) (check-equal? val ...)]))

  (run-tests
   (test-suite "ptx"
    (test-case "remove-comments"
      (== (remove-comments "/* */ == /* /* b */ */") " ==  */")
      (== (remove-comments " a // \n b// c//d//e\\nf\ng") " a \n b\ng")
      (== (remove-comments "/ x/* // a \n // b */ // c \ny") "/ x \ny"))

    (test-case "ptx-parse"
      (== (peg literal "{ { 0x1123, 0, -0123, { 1, 2 } }}")
          '(("0x1123" "0" "-0123" ("1" "2"))))
      (== (peg literal
               "{0d0000000000000000,0d3FF0000000000000,-0,0f01234567}")
          '("0d0000000000000000" "0d3FF0000000000000" "-0" "0f01234567"))
      (== (peg literal "0d3ff0000000000000") "0d3ff0000000000000")

      (== (peg module ".version	3.1")
          '(module ".version	3.1"))
      (== (peg module ".target	sm_35")
          '(module ".target	sm_35"))
      (== (peg module ".address_size 64")
          '(module ".address_size 64"))
      (== (peg module ".version 7.2")
          '(module ".version 7.2"))

      (== (peg debugging ".file	1 \"/path/to/source.c\"")
          '(debugging ".file" "1" "\"/path/to/source.c\""))
      (== (peg debugging ".loc	1 15 1")
          '(debugging ".loc" "1" "15" "1"))

      (== (peg storage ".param .u32 .ptr.global.align 16 param2")
          '(storage ".param" ".u32" ".ptr" ".global" ".align 16" "param2"))
      (== (peg storage ".reg .b32 %r<100>")
          '(storage ".reg" ".b32" "%r<100>"))
      (== (peg storage ".shared .align 8 .b8 S18_main_17_gpu[]")
          '(storage ".shared" ".align 8" ".b8" "S18_main_17_gpu[]"))
      (== (peg storage ".local  .u16 kernel[19][19]")
          '(storage ".local" ".u16" "kernel[19][19]"))

      (== (peg storageN ".const  .f32 bias[] = {-1.0, 1.0}")
          '(storageN ".const" ".f32" ("bias[]" ("-1.0" "1.0"))))
      (== (peg storageN ".reg .u32 %ptr, %n")
          '(storageN ".reg" ".u32" "%ptr" "%n"))
      (== (peg storageN ".reg .u32 %ptr = 10   , %n = 100")
          '(storageN ".reg" ".u32" ("%ptr" "10") ("%n" "100")))

      (== (peg instruction "add.u16 d, a, b")
          '(instruction "add" ".u16" "d" "a" "b"))
      (== (peg instruction "cvt.f32.u16 d, a")
          '(instruction "cvt" ".f32" ".u16" "d" "a"))
      (== (peg instruction "atom.cas.b64	%r26, [%r22], %r26, %r33")
          '(instruction "atom" ".cas" ".b64" "%r26" "[%r22]" "%r26" "%r33"))
      (== (peg instruction "bar.sync  1")
          '(instruction "bar" ".sync" "1"))
      (== (peg instruction "bra $L13")
          '(instruction "bra" "$L13"))

      (== (peg statement "mov.u64 %r25, %r26;")
          '((instruction "mov" ".u64" "%r25" "%r26")))
      (== (peg kernel-body "{ bra	$L8; $L9: @tmp mov.u64 %r25, %r26; }")
          '((instruction "bra" "$L8")
            "$L9:"
            "@tmp"
            (instruction "mov" ".u64" "%r25" "%r26")))

      (== (peg kernel ".entry main$_omp_fn$0 (.param.u64 %in_ar0);")
          '(kernel
            "main$_omp_fn$0"
            (storage ".param" ".u64" "%in_ar0")))
      (== (peg kernel
           ".entry foo ( .param .b32 N, .param .align 8 .b8 buffer[64] );")
          '(kernel
            "foo"
            (storage ".param" ".b32" "N")
            (storage ".param" ".align 8" ".b8" "buffer[64]")))
      (== (peg kernel ".entry foo ( .param .u32 param1,
             .param .u32 .ptr.global.align 16 param2,
             .param .u32 .ptr.const.align 8 param3,
             .param .u32 .ptr.align 16 param4);")
          '(kernel
            "foo"
            (storage ".param" ".u32" "param1")
            (storage ".param" ".u32" ".ptr" ".global" ".align 16" "param2")
            (storage ".param" ".u32" ".ptr" ".const" ".align 8" "param3")
            (storage ".param" ".u32" ".ptr" ".align 16" "param4")))
      (== (peg kernel ".entry bar () .maxntid 16,16,4 .maxnctapersm 4;")
          '(kernel
            "bar"
            (".maxntid" "16" "16" "4")
            (".maxnctapersm" "4")))

      (== (peg kernel ".entry bar () { .section .A { .loc  1 15 1 } }")
          '(kernel
            "bar"
            (debugging ".section" ".A"
                       (group (debugging ".loc" "1" "15" "1")))))

      (== (peg function ".func fname .noreturn;")
          '(function
            "fname"
            ".noreturn"))
      (== (peg function
               (string-append
                ".func (.reg .u32 %res) inc_ptr "
                " ( .reg .u32 %ptr, .reg .u32 %inc ) {"
                " add.u32 %res, %ptr, %inc;  ret; }"))
          '(function
            (storage ".reg" ".u32" "%res")
            "inc_ptr"
            (storage ".reg" ".u32" "%ptr")
            (storage ".reg" ".u32" "%inc")
            (instruction "add" ".u32" "%res" "%ptr" "%inc")
            (instruction "ret")))
      (== (peg linking ".extern .func GOMP_atomic_start;")
          '(linking ".extern" (function "GOMP_atomic_start")))

      (== (peg kernel ptx-register-def) ptx-register-def-out)
      (== (peg kernel ptx-sample1) ptx-sample1-out)

      (== (peg ptx-parser ptx-sample2) ptx-sample2-out)
      (== (peg ptx-parser ptx-sample3) ptx-sample3-out)
      (== (peg ptx-parser ptx-sample4) ptx-sample4-out)
      (== (peg ptx-parser ptx-sample5) ptx-sample5-out)
      (== (peg ptx-parser ptx-sample6) ptx-sample6-out)
      (== (peg ptx-parser (remove-comments ptx-sample7)) ptx-sample7-out)
      (== (peg linking ptx-sample8) ptx-sample8-out)
      (== (peg ptx-parser ptx-sample9) ptx-sample9-out)
      (== (peg ptx-parser ptx-sample10) ptx-sample10-out)
      (== (peg ptx-parser ptx-sample11) ptx-sample11-out)
      (== (peg ptx-parser ptx-sample12) ptx-sample12-out)
      )

    (test-case "ptxasm-to-str"
      (== (storage-to-str
           '(storage ".param" ".u32" ".ptr" ".global" ".align 16" "param2"))
          ".param .u32 .ptr .global .align 16 param2")
      (== (storageN-to-str '(storageN ".reg" ".u32"
                                      ("%ptr" "10") ("%n" "100")))
          ".reg .u32 %ptr = 10, %n = 100;\n")

      (== (group-to-str
           '(group (prototype "prototype_0:" "_"
                              (storage ".param" ".b32" "_")
                              (storage ".param" ".b32" "_"))
                   (instruction "call" "%rd6"
                                "(param0,param1)" "prototype_0")))
          (string-append
           "{\n"
           "prototype_0: .callprototype _ (.param .b32 _, .param .b32 _);"
           "\n"
           "call %rd6, (param0,param1), prototype_0;"
           "\n}\n"))

      (== (top-to-str '(linking ".extern" (function "GOMP_atomic_start")))
          ".extern .func GOMP_atomic_start ;\n")

      (== (function-to-str
           '(function
             (storage ".reg" ".u32" "%res")
             "inc_ptr"
             (storage ".reg" ".u32" "%ptr")
             (storage ".reg" ".u32" "%inc")
             (instruction "add" ".u32" "%res" "%ptr" "%inc")
             (instruction "ret")))
          (string-append
           ".func (.reg .u32 %res) inc_ptr (.reg .u32 %ptr, .reg .u32 %inc)"
           " {\nadd.u32 %res, %ptr, %inc;\nret ;\n}\n"))

      (== (kernel-to-str
           '(kernel
             "bar"
             (".maxntid" "16" "16" "4")
             (".maxnctapersm" "4")))
          ".entry bar .maxntid 16, 16, 4 .maxnctapersm 4 ;\n")
      )
    )))
