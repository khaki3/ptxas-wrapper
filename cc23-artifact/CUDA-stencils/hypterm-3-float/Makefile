NVCC=nvcc
NVPROF=nsys nvprof
NOPTFLAGS=-O3 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-dlcm=ca"
NCOMPUTEFLAGS=-gencode arch=compute_$(GPUARCH),code=sm_$(GPUARCH)

test: orig ptxas
	$(NVPROF) ./orig
	$(NVPROF) ./ptxas

orig:
	nvcc $(NOPTFLAGS) $(NCOMPUTEFLAGS) -o $@ kernel.cu driver.cpp gold.cpp

ptxas:
	PW_ENABLE=1 nvcc $(NOPTFLAGS) $(NCOMPUTEFLAGS) -o $@ kernel.cu driver.cpp gold.cpp

clean:
	rm -f orig ptxas
