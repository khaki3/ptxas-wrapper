//===----------------------------------------------------------------------===//
//
//     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
//        compiler for NVIDIA GPUs, targeting numerical modeling code.
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "openacc_profiling.h"

static char* wrapper_funcname = 0;
static long wrapper_lineno = 0;

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
