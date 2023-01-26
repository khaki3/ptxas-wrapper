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

# KernelGen compiler/linker options
KERNELGEN_GCC ?= kernelgen-gcc -O3 -D_GNU_SOURCE -std=c99

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: gameoflife

gameoflife: gameoflife.o timing.o
	$(SILENT)$(KERNELGEN_GCC) gameoflife.o timing.o -o $@ -lrt

gameoflife.o: ../gameoflife.c ../timing.h
	$(SILENT)$(KERNELGEN_GCC) -Dreal=$(real) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(KERNELGEN_GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o gameoflife

test: gameoflife
	$(SILENT)./$< $(NX) $$(($(NY) * $(NS))) $(NT)

