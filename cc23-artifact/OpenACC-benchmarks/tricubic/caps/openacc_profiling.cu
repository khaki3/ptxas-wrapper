#include <cuda.h>
#include <dlfcn.h>
#include <map>
#include <stdio.h>
#include <string>

using namespace std;

#ifdef __cplusplus
extern "C" {
#endif

#include "openacc_profiling.h"
#include "../timing.h"

static char* wrapper_funcname = 0;
static long wrapper_lineno = 0;

map<string, int> regcounts;

int kernelgen_enable_openacc_regcount(char* funcname, long lineno)
{
        wrapper_funcname = funcname;
        wrapper_lineno = lineno;
        return 0;
}

int kernelgen_disable_openacc_regcount()
{
        wrapper_funcname = 0;
        return 0;
}

void  __real_openacci_call(const char *file_name, int line_number, const char *function_name);

static const char* capture_kernel_launch = NULL;

void  __wrap_openacci_call(const char *file_name, int line_number, const char *function_name)
{
        if (__builtin_expect(wrapper_funcname != NULL, 1))
        {
                if (!strcmp(wrapper_funcname, file_name) &&
                        (wrapper_lineno == line_number))
                {
                        map<string, int>::iterator it = regcounts.find(function_name);
                        if (it == regcounts.end())
                        {
				// Capture and output regcount for the next launch.
				capture_kernel_launch = function_name;
			}
                        else
                        {
                                fprintf(stderr, "%s:%ld regcount = %d\n", wrapper_funcname,
                                        wrapper_lineno, it->second);
                        }
		}
	}

	__real_openacci_call(file_name, line_number, function_name);
}

bool timing = false;
struct timespec kernel_start, kernel_finish;

typedef CUresult (*cuLaunchKernel_t)(
	CUfunction,
	unsigned int,
	unsigned int,
	unsigned int,
	unsigned int,
	unsigned int,
	unsigned int,
	unsigned int,
	CUstream,
	void **,
	void **);
static cuLaunchKernel_t cuLaunchKernel_ = NULL;

CUresult cuLaunchKernel(
	CUfunction f,
	unsigned int gridDimX,
	unsigned int gridDimY,
	unsigned int gridDimZ,
	unsigned int blockDimX,
	unsigned int blockDimY,
	unsigned int blockDimZ,
	unsigned int sharedMemBytes,
	CUstream hStream,
	void **kernelParams,
	void **extra)
{
	if (capture_kernel_launch)
	{
		int regcount = -1;
		CUresult curesult = cuFuncGetAttribute(&regcount, CU_FUNC_ATTRIBUTE_NUM_REGS, f);
		if (curesult != CUDA_SUCCESS)
		{
			fprintf(stderr, "Failed to determine regcount for function %s\n", wrapper_funcname);
			exit(-1);
		}
		regcounts[capture_kernel_launch] = regcount;
		fprintf(stderr, "%s:%ld regcount = %d\n", wrapper_funcname,
			wrapper_lineno, regcount);
		capture_kernel_launch = NULL;
	}

	// Measure kernel time.
	get_time(&kernel_start);
	timing = true;

	return cuLaunchKernel_(f,
		gridDimX, gridDimY, gridDimZ,
		blockDimX, blockDimY, blockDimZ,
		sharedMemBytes, hStream, kernelParams, extra);
}

typedef CUresult (*cuCtxSynchronize_t)();
static cuCtxSynchronize_t cuCtxSynchronize_ = NULL;

CUresult cuCtxSynchronize()
{
	CUresult result = cuCtxSynchronize_();

	if (timing)
	{
		get_time(&kernel_finish);
		fprintf(stderr, "%s:%ld time = %f\n", wrapper_funcname,
			wrapper_lineno, get_time_diff(&kernel_start, &kernel_finish));
		timing = false;
	}

	return result;
}

void* __libc_dlsym(void* handle, const char* symname) __THROW;

void* dlsym(void* handle, const char* symname) __THROW
{
	void* addr = __libc_dlsym(handle, symname);

	if (!strcmp(symname, "cuLaunchKernel"))
	{
		cuLaunchKernel_ = (cuLaunchKernel_t)addr;
		return (void*)&cuLaunchKernel;
	}
	if (!strcmp(symname, "cuCtxSynchronize"))
	{
		cuCtxSynchronize_ = (cuCtxSynchronize_t)addr;
		return (void*)&cuCtxSynchronize;
	}

	return addr;
}

#ifdef __cplusplus
}
#endif
