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

# GCC compiler/linker options
GCC ?= gcc -O3 -D_GNU_SOURCE -std=c99

# Intel compiler/linker options
ICC ?= icc -O3 -D_GNU_SOURCE -D_MIC -std=c99 -openmp-report=2 -vec-report6 -opt-subscript-in-range -align -offload-build

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: laplacian

laplacian: laplacian.o timing.o
	$(SILENT)$(ICC) laplacian.o timing.o -o $@ -lrt

laplacian.o: ../laplacian.c ../timing.h
	$(SILENT)$(ICC) -Dreal=$(real) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o laplacian

test: laplacian
	$(SILENT)./$< $(NX) $(NY) $(NS) $(NT)
