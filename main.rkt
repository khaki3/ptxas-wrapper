#lang rosette

(require
 "ptx.rkt"
 "emulate.rkt")

;; % ptxas --help 2>&1 | sed -n 's/^\(.*\) <.*(\(.*\)).*$/"\1" "\2"/p'
(define flags-with-option
  '("--allow-expensive-optimizations" "-allow-expensive-optimizations"
    "--device-function-maxrregcount" "-func-maxrregcount"
    "--entry" "-e"
    "--fmad" "-fmad"
    "--gpu-name" "-arch"
    "--input-as-string" "-ias"
    "--machine" "-m"
    "--maxrregcount" "-maxrregcount"
    "--opt-level" "-O"
    "--options-file" "-optf"
    "--output-file" "-o"
    "--def-load-cache" "-dlcm"
    "--def-store-cache" "-dscm"

    "--machine" "-m"
    "--opt-level"
    ))

;; % ptxas --help 2>&1 | sed -n 's/^\(--[^ ]*\) *(\(.*\)).*$/"\1" "\2"/p'
(define flags-without-option
  '("--compile-as-tools-patch" "-astoolspatch"
    "--compile-only" "-c"
    "--device-debug" "-g"
    "--disable-optimizer-constants" "-disable-optimizer-consts"
    "--disable-warnings" "-w"
    "--dont-merge-basicblocks" "-no-bb-merge"
    "--extensible-whole-program" "-ewp"
    "--force-load-cache" "-flcm"
    "--force-store-cache" "-fscm"
    "--generate-line-info" "-lineinfo"
    "--help" "-h"
    "--legacy-bar-warp-wide-behavior" "-legacy-bar-warp-wide-behavior"
    "--optimize-float-atomics" "-opt-fp-atomics"
    "--preserve-relocs" "-preserve-relocs"
    "--return-at-end" "-ret-end"
    "--sp-bounds-check" "-sp-bounds-check"
    "--suppress-debug-info" "-suppress-debug-info"
    "--suppress-double-demote-warning" "-suppress-double-demote-warning"
    "--suppress-stack-size-warning" "-suppress-stack-size-warning"
    "--verbose" "-v"
    "--version" "-V"
    "--warn-on-double-precision-use" "-warn-double-usage"
    "--warn-on-local-memory-usage" "-warn-lmem-usage"
    "--warn-on-spills" "-warn-spills"
    "--warning-as-error" "-Werror"

    "--m32" "-m32"
    "--m64" "-m64"
    "-O0" "-O1" "-O2" "-O3" "-O4"
    ))

(define (extract-filename args)
  (if (null? args) #f

      (let ([head (car args)])

        (cond
          [(member head flags-with-option)
           (extract-filename (cddr args))]

          [(let* ([m (regexp-match #rx"(.*)=(.*)" head)]
                  [r (and m (list-ref m 1))])
             (member r flags-with-option))
           (extract-filename (cdr args))]

          [(member head flags-without-option)
           (extract-filename (cdr args))]

          [else head]
          ))))

(define (main args)
  (define filename (extract-filename args))

  (unless filename
    (error "No input"))

  ;; Load PTX
  (define ptxasm (ptx-read filename))

  (unless ptxasm
    (error "Failed to parse" filename))

  ;; Optimize; then, Store PTX
  (ptx-write (emulate ptxasm) filename))

(module+ main
  ;; Define a variable to omit the output of the return value
  (define exit-code (main (vector->list (current-command-line-arguments)))))

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "main"
    (test-case "extract-filename"
      (define gcc-args '("-c" "-o" "/dev/null" "/tmp/ccXuhZoA.o" "--gpu-name" "sm_35" "-O0"))
      (define gcc-file "/tmp/ccXuhZoA.o")
      (define llvm-args '("-m64" "-O3" "--gpu-name" "sm_70" "--output-file" "/tmp/omp-4b445e.cubin" "/tmp/omp-115202.s" "-c"))
      (define llvm-file "/tmp/omp-115202.s")
      (define pgi-args '("-arch=sm_70" "-w" "-m64" "-O3" "-o" "/tmp/pgaccD1TqxfhCgqfQ.bin" "--compile-only" "/tmp/pgacc11TqF5NiESNX.ptx"))
      (define pgi-file "/tmp/pgacc11TqF5NiESNX.ptx")

      (check-equal? (extract-filename gcc-args)  gcc-file )
      (check-equal? (extract-filename llvm-args) llvm-file)
      (check-equal? (extract-filename pgi-args)  pgi-file )

      (define nvptx-none-args '("-m" "sm_35" "-o" "/tmp/cca5iFKt.o" "/tmp/ccKMbo2z.s"))
      (define nvptx-none-file "/tmp/ccKMbo2z.s")

      (check-equal? (extract-filename nvptx-none-args) nvptx-none-file)  )
    )))
