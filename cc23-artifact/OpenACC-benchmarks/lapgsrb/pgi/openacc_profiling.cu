//===----------------------------------------------------------------------===//
//
//     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
//        compiler for NVIDIA GPUs, targeting numerical modeling code.
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <cuda.h>
#include <map>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>

using namespace std;

#ifdef __cplusplus
extern "C" {
#endif

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

struct uaccbinrec_t
{
	int binaryid;
	int fill;
	size_t binlen;
	char** binary;
};

struct uaccfuncrec_t
{
	int flags;
	int fill;
	long int lineno;
	char* functionname;
	// More args follow.
};

struct vinfo_t
{
	int magic;
	int flags;
	int pflags;
	int numfunctions;
	int numbinaries;
	int lock;
	void** handle;
	void** funchandle;
	uaccbinrec_t* bin;
	uaccfuncrec_t* func;
};

void __real___pgi_uacc_cuda_launch(vinfo_t* vinfo, int funcnum, void* argptr,
	long int* sargs, long int async, int dindex);

void __wrap___pgi_uacc_cuda_launch(vinfo_t* vinfo, int funcnum, void* argptr,
        long int* sargs, long int async, int dindex)
{
	if (__builtin_expect(wrapper_funcname != NULL, 1))
	{
		char* funcname = vinfo->func->functionname;
		long int lineno = vinfo->func->lineno;
		if (!strcmp(wrapper_funcname, funcname) &&
			(wrapper_lineno == lineno))
		{
			map<string, int>::iterator it = regcounts.find(funcname);
			if (it == regcounts.end())
			{
				// Get the register count for the underlying image.
				CUmodule module;
				CUresult curesult = cuModuleLoadData(&module, (char*)vinfo->bin->binary);
				if (curesult != CUDA_SUCCESS)
				{
					fprintf(stderr, "Failed to load module from handle %p\n", vinfo->bin->binary);
					exit(-1);				
				}
				CUfunction func;
				curesult = cuModuleGetFunction(&func, module, funcname);
				if (curesult != CUDA_SUCCESS)
				{
					fprintf(stderr, "Failed to load function %s from module handle %p\n",
						funcname, vinfo->bin->binary);
					exit(-1);
				}
				int regcount = -1;
				curesult = cuFuncGetAttribute(&regcount, CU_FUNC_ATTRIBUTE_NUM_REGS, func);
				if (curesult != CUDA_SUCCESS)
				{
					fprintf(stderr, "Failed to determine regcount for function %s\n", funcname);
					exit(-1);
				}
				regcounts[funcname] = regcount;
				curesult = cuModuleUnload(module);
				if (curesult != CUDA_SUCCESS)
				{
					fprintf(stderr, "Failed to unload module from handle %p\n", vinfo->bin->binary);
					exit(-1);				
				}
				fprintf(stderr, "%s:%ld regcount = %d\n", wrapper_funcname,
					lineno, regcount);
			}
			else
			{
				fprintf(stderr, "%s:%ld regcount = %d\n", wrapper_funcname,
					lineno, it->second);
			}
		}
	}

	__real___pgi_uacc_cuda_launch(vinfo, funcnum, argptr, sargs, async, dindex);
}

#ifdef __cplusplus
}
#endif

