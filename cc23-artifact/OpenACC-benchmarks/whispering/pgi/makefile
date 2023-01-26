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
GPUARCH ?= 20
GPUCUDA ?= 5.0
PGCC ?= pgcc -I. -acc -O3 -Minfo=accel -ta=nvidia:keep,cc$(GPUARCH),cuda$(GPUCUDA) -Wl,--wrap=__pgi_uacc_cuda_launch
PGF90 ?= pgf90 -acc -O3 -Minfo=accel -ta=nvidia:keep,cc$(GPUARCH),cuda$(GPUCUDA) -Wl,--wrap=__pgi_uacc_cuda_launch $(pgi_szreal)

# NVIDIA compile options
NVCC ?= nvcc -O3

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: whispering

whispering: whispering.o timing.o # openacc_profiling.o
	$(SILENT)$(PGCC) $^ -o $@ -lrt -L$(shell dirname $(shell which nvcc))/../lib64 -lstdc++ -lgcc_s

whispering.o: ../whispering.c ../timing.h
	$(SILENT)$(PGCC) -Dreal=$(real) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(PGCC) -c $< -o $@

openacc_profiling.o: openacc_profiling.cu
	$(SILENT)$(NVCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o whispering *.ptx *.gpu *.bin

test: whispering
	$(SILENT)PGI_ACC_TIME=1 ./$< $(NX) $$(($(NY) * $(NS))) $(NT)

