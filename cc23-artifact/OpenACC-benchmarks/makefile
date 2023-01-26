##===----------------------------------------------------------------------===##
##
##     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
##        compiler for NVIDIA GPUs, targeting numerical modeling code.
##
## This file is distributed under the University of Illinois Open Source
## License. See LICENSE.TXT for details.
##
##===----------------------------------------------------------------------===##

-include makefile.in

TARGETS = \
	divergence \
	 gaussblur \
	    jacobi \
	 laplacian \
	    matmul \
	    matvec \
	  tricubic \
	      uxx1 \
	  wave13pt \
	gameoflife \
	  gradient \
	   lapgsrb \
	    sincos \
	 tricubic2 \
	    vecadd \
	whispering

TARGETS_GCC = $(addsuffix .gcc, $(TARGETS))
TARGETS_GCC_CLEAN = $(addsuffix .gcc.clean, $(TARGETS))

TARGETS_KERNELGEN = $(addsuffix .kernelgen, $(TARGETS))
TARGETS_KERNELGEN_CLEAN = $(addsuffix .kernelgen.clean, $(TARGETS))

TARGETS_MIC = $(addsuffix .mic, $(TARGETS))
TARGETS_MIC_CLEAN = $(addsuffix .mic.clean, $(TARGETS))

TARGETS_PATHSCALE = $(addsuffix .pathscale, $(TARGETS))
TARGETS_PATHSCALE_CLEAN = $(addsuffix .pathscale.clean, $(TARGETS))

TARGETS_PGI = $(addsuffix .pgi, $(TARGETS))
TARGETS_PGI_CLEAN = $(addsuffix .pgi.clean, $(TARGETS))

TARGETS_CAPS = $(addsuffix .caps, $(TARGETS))
TARGETS_CAPS_CLEAN = $(addsuffix .caps.clean, $(TARGETS))

TARGETS_PATUS = $(addsuffix .patus, $(TARGETS))
TARGETS_PATUS_CLEAN = $(addsuffix .patus.clean, $(TARGETS))

.PHONY: all

all: gcc kernelgen mic pathscale pgi caps

gcc: $(TARGETS_GCC)

kernelgen: $(TARGETS_KERNELGEN)

mic: $(TARGETS_MIC)

pathscale: $(TARGETS_PATHSCALE)

pgi: $(TARGETS_PGI)

caps: $(TARGETS_CAPS)

patus: $(TARGETS_PATUS)

clean: $(TARGETS_GCC_CLEAN) $(TARGETS_KERNELGEN_CLEAN) $(TARGETS_MIC_CLEAN) $(TARGETS_PATHSCALE_CLEAN) $(TARGETS_PGI_CLEAN) $(TARGETS_CAPS_CLEAN) $(TARGETS_PATUS_CLEAN)

%.gcc:
	$(SILENT)cd $(subst .gcc,,$@)/gcc && $(MAKE)
	
%.gcc.clean:
	$(SILENT)cd $(subst .gcc.clean,,$@)/gcc && $(MAKE) clean

%.kernelgen:
	$(SILENT)cd $(subst .kernelgen,,$@)/kernelgen && $(MAKE)

%.kernelgen.clean:
	$(SILENT)cd $(subst .kernelgen.clean,,$@)/kernelgen && $(MAKE) clean

%.mic:
	$(SILENT)cd $(subst .mic,,$@)/mic && $(MAKE)

%.mic.clean:
	$(SILENT)cd $(subst .mic.clean,,$@)/mic && $(MAKE) clean

%.pathscale:
	$(SILENT)cd $(subst .pathscale,,$@)/pathscale && $(MAKE)

%.pathscale.clean:
	$(SILENT)cd $(subst .pathscale.clean,,$@)/pathscale && $(MAKE) clean

%.pgi:
	$(SILENT)cd $(subst .pgi,,$@)/pgi && $(MAKE)

%.pgi.clean:
	$(SILENT)cd $(subst .pgi.clean,,$@)/pgi && $(MAKE) clean

%.caps:
	$(SILENT)cd $(subst .caps,,$@)/caps && $(MAKE)

%.caps.clean:
	$(SILENT)cd $(subst .caps.clean,,$@)/caps && $(MAKE) clean

%.patus:
	$(SILENT)cd $(subst .patus,,$@)/patus && $(MAKE)

%.patus.clean:
	$(SILENT)cd $(subst .patus.clean,,$@)/patus && $(MAKE) clean

test.gcc: $(TARGETS_GCC)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) gcc

test.kernelgen: $(TARGETS_KERNELGEN)
	$(SILENT)kernelgen_runmode=1 kernelgen_szheap=$$((1024*1024*800)) kernelgen_verbose=$$((1<<6)) ./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) kernelgen

test.mic: $(TARGETS_MIC)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) mic

test.pathscale: $(TARGETS_PATHSCALE)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) pathscale

test.pgi: $(TARGETS_PGI)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) pgi

test.caps: $(TARGETS_CAPS)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) caps

test.patus: $(TARGETS_PATUS)
	$(SILENT)./benchmark $(NX) $(NY) $(NS) $(NT) $(NRUNS) patus

