#!/bin/bash

: ${GPUARCH:=70}
: ${GPUCUDA:=11.6}

export GPUARCH
export GPUCUDA

BENCHMARKS="divergence gameoflife gaussblur gradient jacobi lapgsrb"
BENCHMARKS="$BENCHMARKS laplacian matmul matvec sincos tricubic tricubic2"
BENCHMARKS="$BENCHMARKS uxx1 vecadd wave13pt whispering"

if [ -z ${PW_ENABLE+x} ]; then
    SYM=ORIGINAL
elif [ ! -z ${PW_NOLOAD+x} ]; then
    SYM=NOLOAD
elif [ ! -z ${PW_NOCORNER+x} ]; then
    SYM=NOCORNER
else
    SYM=NORMAL
fi

for bench in $BENCHMARKS; do
    cp -r $bench/pgi/. $bench/pgi.$SYM
    pushd $bench/pgi.$SYM >/dev/null
    echo == $bench
    make clean >/dev/null
    make 2>&1 | egrep ^LOAD\|^ptxas\|spill\|real
    popd >/dev/null
done
