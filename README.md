## ptxas-wrapper

A wrapper of ptxas for optimization of directive-based programming models.

### Usage
- GCC: replace `as` of nvptx-none
- LLVM: set $CUDA_HOME to point to a local CUDA with a replaced `ptxas`
- PGI: replace `ptxas` of a bundled CUDA

### Replacement
First,

```
% raco pkg install peg rosette
```

Then, edit $HOME/.local/share/racket/8.X/pkgs/rosette/rosette/query/core.rkt as

```
@@ -16,7 +16,8 @@
                   (lambda (s)
                     (unless (solver? s)
                       (error 'current-solver "expected a solver?, given ~s" s))
-                    (solver-shutdown (current-solver))
+                    ;; [KM] Comment out for multithreading
+                    ;; (solver-shutdown (current-solver))
                     s)))
```

Finally,
```
% make
```

#### PGI/LLVM
```
% cd /path/to/cuda/bin
% mv ptxas ptxas.back
```

Then, put this script as a new `ptxas` applying `chmod +x ptxas`:
```
#!/bin/bash

PARENT="$(cat /proc/$PPID/cmdline | tr '\0' '\t' | cut -f 1)"

if [[ $PARENT != *"nvptx-none/bin/as"* ]] && [[ ! -z "${PW_ENABLE}" ]]; then
    time /path/to/ptxas-wrapper/ptxas-wrapper "$@"
fi

$(dirname $(realpath $0))/ptxas.back "$@"
```

#### GCC

```
% cd /path/to/nvptx-none/bin
% mv as as.back
```

Then, put this script as a new `as` applying `chmod +x as`:
```
#!/bin/bash

if [[ ! -z "${PW_ENABLE}" ]]; then
    time /path/to/ptxas-wrapper/ptxas-wrapper "$@"
fi

$(dirname $(realpath $0))/as.back "$@"
```
