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
szreal ?=
ifeq ($(real), double)
szreal ?= -fdefault-real-8
endif

# KernelGen compiler/linker options
KERNELGEN_GCC ?= kernelgen-gcc -O3 -D_GNU_SOURCE -std=c99
KERNELGEN_GFORTRAN ?= kernelgen-gfortran -O3 $(szreal)

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: sincos

sincos: main.o sincos.o timing.o
	$(SILENT)$(KERNELGEN_GFORTRAN) $^ -o $@ -lrt

main.o: ../main.c ../timing.h
	$(SILENT)$(KERNELGEN_GCC) -Dreal=$(real) -c $< -o $@

sincos.o: ../sincos.F90 ../timing.h
	$(SILENT)$(KERNELGEN_GFORTRAN) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(KERNELGEN_GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o sincos

test: sincos
	$(SILENT)./$< $(NX) $(NY) $(NS) $(NT)
