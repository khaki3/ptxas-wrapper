#lang racket

(require (only-in srfi/1 list-index iota fold))

(provide (all-defined-out))

(define ~ list-ref)

(define (acons key val alist)
  (cons (cons key val) alist))

(define (assoc-adjoin alist key val)
  (define index (list-index (lambda (x) (equal? (car x) key)) alist))
  (if (not index) (acons key val alist)
      (let ()
        (define-values (l r) (split-at alist index))
        (append l (acons key val (cdr r))))))

(define (assoc-ref alist key)
  (define x (assoc key alist))
  (and x (cdr x)))

(define (group-by-n lst n)
  (define len (length lst))
  (define sub (ceiling (/ len n)))
  (define pos (map (lambda (i) (iota n i)) (iota sub 0 n)))
  (define kons (lambda (i nil) (if (< i len) (cons (~ lst i) nil) nil)))
  (map (lambda (p) (reverse (fold kons '() p))) pos))

(define (string-encode x)
  (define bytes (string->bytes/utf-8 x))
  (define lst (bytes->list bytes))
  (define hex (map (curryr number->string 16) lst))
  (define str (apply string-append hex))
  (define num (string->number str 16))
  num)

(define (string-decode x)
  (define str (number->string x 16))
  (define bytes (hexstring->bytes str))
  (bytes->string/utf-8 bytes))

(define (hexstring->bytes x)
  (define hex (map list->string (group-by-n (string->list x) 2)))
  (define lst (map (curryr string->number 16) hex))
  (define bytes (list->bytes lst))
  bytes)

(define-syntax and-let*-decl
  (syntax-rules ()
    [(_ (var expr))
     (define var expr)]

    [(_ (expr)) #f]

    [(_ var) #f]))

(define-syntax and-let*-cond
  (syntax-rules ()
    [(_ (var expr)) var]

    [(_ (expr)) expr]

    [(_ var) var]))

(define-syntax and-let*
  (syntax-rules ()
    ([_ () body ...]
     (let () body ...))

    [(_ (x) body ...)
     (let ()
       (and-let*-decl x)
       (if (and-let*-cond x) (let () body ...) #f))]

    [(_ (x y ...) body ...)
     (and-let* (x) (and-let* (y ...) body ...))]))

(define-syntax and-let1
  (syntax-rules ()
    ([_ var val body ...]
     (and-let* ([var val]) body ...))))

(define (dig proc x)
  (cond [(proc x) (list x)]
        [(not (pair? x)) '()]
        [else (append-map (curry dig proc) x)]))

(module+ test
  (require rackunit rackunit/text-ui)
  (define-syntax ==
    (syntax-rules ()
      [(_ val ...) (check-equal? val ...)]))

  (run-tests
   (test-suite "util"
    (test-case "~"
      (define lst (iota 100))
      (== (~ lst 82) 82)
      )

    (test-case "acons"
      (define lst1 '((a . b)))
      (define lst2 '((c . d) (a . b)))
      (== (acons 'c 'd lst1) lst2)
      )

    (test-case "assoc-adjoin"
      (define lst '((a . 0)))
      (== (assoc-adjoin lst 'a 10) '((a . 10)))
      (== (assoc-adjoin lst 'b 10) '((b . 10) (a . 0)))
      )

    (test-case "assoc-ref"
      (define lst '((a . 0) (b . 1) (c . 2) (d . 3)))
      (== (assoc-ref lst 'c) 2)
      (== (assoc-ref lst 'e) #f)
      )

    (test-case "group-by-n"
      (define lst (iota 982))
      (define grp (group-by-n lst 73))
      (== (apply append grp) lst)
      )

    (test-case "string-encode"
      (define str1 "abcdefg")
      (define str2 "omptarget_nvptx_device_State")
      (== (string-decode (string-encode str1)) str1)
      (== (string-decode (string-encode str2)) str2)
      )

    (test-case "hexstring->bytes"
      (define str "40400000")
      (define bytes #"\x40\x40\x00\x00")
      (== (hexstring->bytes str) bytes)
      )

    (test-case "and-let*"
      (== (and-let* ([a 10]) a) 10)
      (== (and-let* ([a 10] [b a]) b) 10)
      (== (and-let* ([a 10] [b (not a)]) a) #f)
      (== (and-let* ([a 10] a [b a] b) b) 10)
      (== (and-let* ([a 10] a [b a] (b)) b) 10)
      (== (and-let* ([a 10] [(not a)] [b a] (b)) b) #f)
      (== (and-let1 a (not #t) 10) #f)
      (== (and-let1 a (not #f) 10) 10)
      (== (and-let1 a (not #f) 10 20) 20)
      )

    (test-case "dig"
      (== (dig (lambda (x) (and (number? x) (=  x 3))) '(2 3 (3 2 ( 3 ))))
          '(3 3 3))
      (== (dig (lambda (x) (and (pair? x) (= (car x) 3))) '(2 3 (3 2 ( 3 ))))
          '((3 2 (3))))
      )
    )))
