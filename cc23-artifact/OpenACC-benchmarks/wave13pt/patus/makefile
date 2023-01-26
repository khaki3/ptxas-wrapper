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

all: wave13pt

wave13pt: wave13pt.o $(KERNEL).o timing.o
	$(SILENT)$(PATUS_GCC) $^ -o $@ -lrt

wave13pt.o: ../wave13pt.c ../timing.h
	$(SILENT)$(PATUS_GCC) -Dreal=$(real) -c $< -o $@
	
$(KERNEL).o: $(KERNEL).c
	$(SILENT)$(PATUS_GCC) -c $< -o $@

$(KERNEL).c: ../wave13pt.stc
	$(SILENT)$(PATUS) --outdir=bench $<
	$(SILENT)make --directory=bench
	$(SILENT)make --directory=bench tune nx=$(NX) ny=$(NY) ns=$(NS)
	$(SILENT)cp bench/kernel.c $(KERNEL).c
	$(SILENT)cp bench/*.h .

timing.o: ../timing.c ../timing.h
	$(SILENT)$(PATUS_GCC) -c $< -o $@

clean:
	$(SILENT)rm -rf kernel.* *.h *.o wave13pt bench

test: wave13pt
	$(SILENT)./$< $(NX) $(NY) $(NS) $(NT)

