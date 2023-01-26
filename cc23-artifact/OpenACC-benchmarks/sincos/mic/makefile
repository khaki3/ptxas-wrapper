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

# GCC compiler/linker options
GCC ?= gcc -O3 -D_GNU_SOURCE -std=c99

# Intel compiler/linker options
ICC ?= icc -O3 -D_GNU_SOURCE -D_MIC -std=c99 -openmp-report=2 -vec-report6 -opt-subscript-in-range -align -offload-build
IFORT ?= ifort -O3 -D_MIC -openmp-report=2 -vec-report6 -opt-subscript-in-range -align -offload-build $(szreal)

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: sincos

sincos: main.o sincos.o timing.o
	$(SILENT)$(IFORT) -nofor-main $^ -o $@ -lrt

main.o: ../main.c ../timing.h
	$(SILENT)$(ICC) -Dreal=$(real) -c $< -o $@

sincos.o: ../sincos.F90
	$(SILENT)$(IFORT) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o sincos

test: sincos
	$(SILENT)./$< $(NX) $(NY) $(NS) $(NT)
