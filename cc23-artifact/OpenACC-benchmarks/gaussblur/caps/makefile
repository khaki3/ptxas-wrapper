##===----------------------------------------------------------------------===##
##
##     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
##        compiler for NVIDIA GPUs, targeting numerical modeling code.
##
## This file is distributed under the University of Illinois Open Source
## License. See LICENSE.TXT for details.
##
##===----------------------------------------------------------------------===##

-include ../../makefile.in

# Verbose setting
VERBOSE ?= 0
SILENT ?= @
ifeq ($(VERBOSE), 1)
SILENT =
endif

# Floating-point type: float or double
real ?= float

# PGI/OpenACC compiler/linker options
GPUARCH ?= 30
GPUCUDA ?= 5.0
CAPSCC ?= hmpp --openacc-target=CUDA -k -f --nvcc-options -O3,-arch,sm_$(GPUARCH) gcc -O3 -D_GNU_SOURCE -std=c99 -Wl,--wrap=openacci_call -Wl,--wrap=dlsym
CAPSF90 ?= hmpp --openacc-target=CUDA -k -f --nvcc-options -O3,-arch,sm_$(GPUARCH) gfortran -O3 $(szreal) -Wl,--wrap=openacci_call -Wl,--wrap=dlsym

# NVIDIA compile options
NVCC ?= nvcc -O3

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: gaussblur

gaussblur: gaussblur.o timing.o # openacc_profiling.o
	$(SILENT)$(CAPSCC) $^ -o $@ -lrt -L$(shell dirname $(shell which nvcc))/../lib64 -lcudart -lcuda -ldl

gaussblur.o: ../gaussblur.c ../timing.h
	$(SILENT)$(CAPSCC) -Dreal=$(real) -c $< -o $@

timing.o: ../timing.c ../timing.h openacc_profiling.h
	$(SILENT)$(CAPSCC) -c $< -o $@

openacc_profiling.o: openacc_profiling.cu openacc_profiling.h
	$(SILENT)$(NVCC) -g -c $< -o $@

clean:
	$(SILENT)rm -rf *.o gaussblur __hmpp_acc_region__* *.i *.fatbin

test: gaussblur
	$(SILENT)HMPPRT_LOG_LEVEL=info ./$< $(NX) $$(($(NY) * $(NS))) $(NT)
