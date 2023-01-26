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

# PathScale/OpenACC compiler/linker options
PATHCC = $(PATHCCPATH)pathcc $(PATHCCAPI) -O3 -I. -I$(PATHCC_INCLUDE_PATH)
PATHF90 = $(PATHCCPATH)pathf90 $(PATHCCAPI) -O3 -I$(PATHCC_INCLUDE_PATH)

# Default problem domain dimensions
NX ?= 512
NY ?= 256
NS ?= 256

all: gameoflife

gameoflife: gameoflife.o timing.o # openacc_profiling.o
	$(SILENT)$(PATHCC) $^ -o $@ -lrt

gameoflife.o: ../gameoflife.c ../timing.h
	$(SILENT)$(PATHCC) -Dreal=$(real) -c $< -o $@

timing.o: ../timing.c ../timing.h
	$(SILENT)$(PATHCC) -c $< -o $@

openacc_profiling.o: openacc_profiling.c
	$(SILENT)$(PATHCC) -c $< -o $@

clean:
	$(SILENT)rm -rf *.o gameoflife *.ptx *.gpu *.bin

test: gameoflife
	$(SILENT)ACC_TIME=1 ./$< $(NX) $$(($(NY) * $(NS))) $(NT)

