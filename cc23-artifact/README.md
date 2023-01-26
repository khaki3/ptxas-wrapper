# PTXASW-Artifact
This archive provides the artifact to manifest our paper "A Symbolic Emulator for Shuffle Synthesis on the NVIDIA PTX Code" (to be presented at CC 2023). We evaluated the generated code by our PTX-optimizer PTXASW.

## Install with Dockerfile
We provide Dockerfile to build a container by the NVIDIA Container Toolkit. You would find two benchmarks inside the container for the artifact evaluation.
```sh
# Set your Compute Capability to GPUARCH (Kepler: 35, Maxwell: 50, Pascal: 60, Volta: 70)
% docker build -t cc23_05 . --build-arg GPUARCH=60
% docker run -v ~/:/work -it --rm --gpus all cc23_05

====================
== NVIDIA HPC SDK ==
====================
 
NVIDIA HPC SDK version 22.3
 
Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.

root@8a5f1c1e39d9:~# ls
CUDA-stencils  OpenACC-benchmarks  ptxas-wrapper  rosette.patch
```

## Caution
On Docker, there is latency for launching subprocesses from Racket. Therefore, the reported analysis time shown during `docker build` as below is usually longer than the time reported in the paper.
```
>LOAD:6 SHUFFLE:1 AVERAGE:2.00 POSSIBLE-BIDIR:0
>real    0m12.234s
```

## OpenACC Evaluation
To generate plots from the results of the OpenACC benchmarks, you need to run all the benchmarks first:
```sh
% cd OpenACC-benchmarks/
% ./RUN.sh; PW_ENABLE=1 ./RUN.sh; PW_ENABLE=1 PW_NOLOAD=1 ./RUN.sh; PW_ENABLE=1 PW_NOCORNER=1 ./RUN.sh;
% PW_PROFILE=1 ./RUN.sh; PW_PROFILE=1 PW_ENABLE=1 ./RUN.sh; PW_PROFILE=1 PW_ENABLE=1 PW_NOLOAD=1 ./RUN.sh; PW_PROFILE=1 PW_ENABLE=1 PW_NOCORNER=1 ./RUN.sh
```

Then, you see generated output:
```sh
% ls *.log
NOCORNER.20230101_101200.log  NORMAL.20230420_101200.log    PROF_NOCORNER.20230101_101200.log  PROF_NORMAL.20230420_101200.log
NOLOAD.20230101_101200.log    ORIGINAL.20230101_101200.log  PROF_NOLOAD.20230101_101200.log    PROF_ORIGINAL.20230101_101200.log
```

You can check the results with plots as:
```sh
% python3 LOG/plot-speedup2.py .
% mv plot.pdf speedup.pdf
% python3 LOG/plot-stall2.py .
% mv plot.pdf stall.pdf
% cp *.pdf /work/ # Copy to your home directory
```

## CUDA Evaluation
Run commands below. You will see the kernel execution time:
```sh
% cd CUDA-stencils/
% cd derivative-2-float; make; cd ..;
% cd hypterm-3-float; make; cd ..;
% cd rhs4th3fort-3-float; make; cd ..;
```
