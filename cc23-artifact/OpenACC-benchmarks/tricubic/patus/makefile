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

# PATUS compiler
PATUS ?= patus

# PATUS-specific GCC compiler options
PATUS_GCC ?= gcc -O3 -mavx -fopenmp -std=c99 -D_GNU_SOURCE -D_PATUS

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

KERNEL = kernel.$(NX).$(NY).$(NS)

all: tricubic

tricubic: tricubic.o $(KERNEL).o timing.o
	$(SILENT)$(PATUS_GCC) $^ -o $@ -lrt

tricubic.o: ../tricubic.c ../timing.h
	$(SILENT)$(PATUS_GCC) -Dreal=$(real) -c $< -o $@
	
$(KERNEL).o: $(KERNEL).c
	$(SILENT)$(PATUS_GCC) -c $< -o $@

$(KERNEL).c: ../tricubic.stc
	$(SILENT)$(PATUS) --outdir=bench --create-inline-asm=no $<
	$(SILENT)make --directory=bench
	$(SILENT)make --directory=bench tune nx=$(NX) ny=$(NY) ns=$(NS)
	$(SILENT)cp bench/kernel.c $(KERNEL).c
	$(SILENT)cp bench/*.h .

timing.o: ../timing.c ../timing.h
	$(SILENT)$(PATUS_GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf kernel.* *.h *.o tricubic bench

test: tricubic
	$(SILENT)./$< $(NX) $(NY) $(NS) $(NT)

