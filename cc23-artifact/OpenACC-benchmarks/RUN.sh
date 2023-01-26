#!/bin/bash

: ${GPUARCH:=70}
: ${GPUCUDA:=11.6}
: ${CUDA_VISIBLE_DEVICES=0}

export GPUARCH
export GPUCUDA
export CUDA_VISIBLE_DEVICES

BM3D="divergence gradient lapgsrb laplacian tricubic tricubic2 uxx1 wave13pt"
BM2D="gameoflife gaussblur jacobi whispering"

BENCHMARKS="divergence gameoflife gaussblur gradient jacobi lapgsrb laplacian"
BENCHMARKS="$BENCHMARKS tricubic tricubic2 uxx1 wave13pt whispering"

PROF_METRICS="stall_memory_dependency,stall_memory_throttle,stall_exec_dependency,stall_pipe_busy"
PROF_METRICS="$PROF_METRICS,achieved_occupancy,stall_sync,warp_execution_efficiency"
PROF_METRICS="$PROF_METRICS,stall_constant_memory_dependency,stall_inst_fetch,stall_not_selected,stall_other,stall_texture"

NOW=`date +%Y%m%d_%H%M%S`
OUT=$NOW.log

# export PW_ENABLE=1
# export PW_NOLOAD=1
# export PW_NOCORNER=1
# export PW_PROFILE=1

if [ -z ${PW_ENABLE+x} ]; then
    SYM=ORIGINAL
elif [ ! -z ${PW_NOLOAD+x} ]; then
    SYM=NOLOAD
elif [ ! -z ${PW_NOCORNER+x} ]; then
    SYM=NOCORNER
else
    SYM=NORMAL
fi

OUT=$SYM.$OUT

if [ ! -z ${PW_PROFILE+x} ]; then
    OUT=PROF_$OUT
fi

exec > >(tee -ia $OUT) 2>&1

for bench in $BENCHMARKS; do
    pushd $bench/pgi.$SYM >/dev/null
    echo == $bench $SYM

    cmd=()
    if [ ! -z ${PW_PROFILE+x} ]; then
        cmd+=(nvprof --csv --metrics $PROF_METRICS)
    fi

    cmd+=(./$bench)
    if [ $bench = "uxx1" ]; then
        cmd+=(512 512 1024 10)
    elif [ $bench = "whispering" ]; then
        cmd+=(8192 16384 10)
    elif echo $BM3D | grep -w -q $bench; then
        cmd+=(512 1024 1024 10)
    else
        cmd+=(32768 32768 10)
    fi

    ${cmd[@]}

    popd >/dev/null
done
