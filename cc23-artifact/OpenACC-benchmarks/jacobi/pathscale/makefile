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
pgi_szreal =
ifeq ($(real), double)
pgi_szreal = -r8
endif

# PathScale/OpenACC compiler/linker options
PATHCC = $(PATHCCPATH)pathcc $(PATHCCAPI) -O3 -I. -I$(PATHCC_INCLUDE_PATH)
PATHF90 = $(PATHCCPATH)pathf90 $(PATHCCAPI) -O3 -I$(PATHCC_INCLUDE_PATH)

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: jacobi

jacobi: main.o jacobi.o timing.o # openacc_profiling.o
	$(SILENT)$(PATHCC) $^ -o $@ -lrt

main.o: ../main.c ../timing.h
	$(SILENT)$(PATHCC) -Dreal=$(real) -c $< -o $@

jacobi.o: ../jacobi.F90
	$(SILENT)$(PATHF90) $(pgi_szreal) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(PATHCC) -c $< -o $@

openacc_profiling.o: openacc_profiling.c
	$(SILENT)$(PATHCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o jacobi *.ptx *.gpu *.bin

test: jacobi
	$(SILENT)ACC_TIME=1 ./$< $(NX) $$(($(NY) * $(NS))) $(NT)

