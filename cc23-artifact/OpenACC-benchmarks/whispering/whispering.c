//===----------------------------------------------------------------------===//
//
//     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
//        compiler for NVIDIA GPUs, targeting numerical modeling code.
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>

#include "timing.h"

#if defined(_OPENACC)
#include <openacc.h>
#include "openacc_profiling.h"
#endif

// Memory alignment, for vectorization on MIC.
// 4096 should be best for memory transfers over PCI-E.
#define MEMALIGN 4096

#define _A(array, ix, iy) (array[(ix) + nx * (iy)])

// PATUS-generated kernel declaration.
#if defined(_PATUS)
void whispering_patus(
	real** dummy1, real** dummy2, real** dummy3, real** dummy4,
	real* e0_0, real* e0_1, real* e1_0, real* e1_1,
	real* h0, real* h1, real* u_em0, real* u_em1,
	real* ca, real* cb, real* da, real* db,
	real mu, real epsilon, int nx, int ny);
#endif

#if defined(_MIC)
__attribute__((target(mic)))
#endif
int whispering(int nx, int ny,
	const real mu, const real epsilon,
	real* e0[2], real* e1[2], real* h0, real* h1, real* u_em0, real* u_em1,
	real* ca, real* cb, real* da, real* db)
{
	real *e0_0 = NULL;
	real *e0_1 = NULL;
	real *e1_0 = NULL;
	real *e1_1 = NULL;
#if defined(_PATUS)
	real *dummy1, *dummy2, *dummy3, *dummy4;
	#pragma omp parallel
	whispering_patus(&dummy1, &dummy2, &dummy3, &dummy4,
		e0[0], e0[1], e1[0], e1[1], h0, h1, u_em0, u_em1,
		ca, cb, da, db, mu, epsilon, nx, ny);
#else
#if defined(_OPENACC)
	size_t szarray = (size_t)nx * ny;
	e0_0 = e0[0];
	e0_1 = e0[1];
	e1_0 = e1[0];
	e1_1 = e1[1];
#pragma acc kernels loop independent gang(65535) present(e0_0[0:szarray], e0_1[0:szarray], e1_0[0:szarray], e1_1[0:szarray])
//		e1[0][0:szarray], e1[1][0:szarray], h0[0:szarray], h1[0:szarray], \
//		u_em0[0:szarray])
// u_em1[0:szarray], ca[0:szarray], cb[0:szarray], da[0:szarray], db[0:szarray])
#endif
#if defined(_OPENMP) || defined(_MIC)
	#pragma omp parallel for
#endif
	for (int j = 1; j < ny - 1; j++)
	{
#if defined(_OPENACC)
		#pragma acc loop independent vector(512)
#endif
		for (int i = 1; i < nx - 1; i++)
		{
			real e0_new = _A(ca, i, j) * _A(e0_0, i, j) + _A(cb, i, j) * (_A(h0, i, j+1) - _A(h0, i, j));
			real e1_new = _A(ca, i, j) * _A(e0_1, i, j) - _A(cb, i, j) * (_A(h0, i+1, j) - _A(h0, i, j));
        
			real ey = _A(ca, i, j-1) * _A(e0_0, i, j-1) + _A(cb, i, j-1) * (_A(h0, i, j) - _A(h0, i, j-1));
			real ex = _A(ca, i-1, j) * _A(e0_1, i-1, j) - _A(cb, i-1, j) * (_A(h0, i, j) - _A(h0, i-1, j));

			_A(e1_0, i, j) = e0_new;
			_A(e1_1, i, j) = e1_new;

			real h = _A(da, i, j) * _A(h0, i, j) + _A(db, i, j) * (e0_new - ey + ex - e1_new);;
			_A(h1, i, j) = h;
			
			_A(u_em1, i, j) = _A(u_em0, i, j) + 0.5 * (h * h / mu + epsilon * (e0_new * e0_new + e1_new * e1_new));
		}
	}
#endif
	return 0;
}

#define parse_arg(name, arg) \
	int name = atoi(arg); \
	if (name < 0) \
	{ \
		printf("Value for " #name " is invalid: %d\n", name); \
		exit(1); \
	}

#define real_rand() (((real)(rand() / (double)RAND_MAX) - 0.5) * 2)

int main(int argc, char* argv[])
{
	if (argc != 4)
	{
		printf("Usage: %s <nx> <ny> <nt>\n", argv[0]);
		exit(1);
	}

	const char* no_timing = getenv("NO_TIMING");

#if defined(_OPENACC)
	char* regcount_fname = getenv("OPENACC_PROFILING_FNAME");
	if (regcount_fname)
	{
		char* regcount_lineno = getenv("OPENACC_PROFILING_LINENO");
		int lineno = -1;
		if (regcount_lineno)
			lineno = atoi(regcount_lineno);
		//kernelgen_enable_openacc_regcount(regcount_fname, lineno);
	}
#endif

	parse_arg(nx, argv[1]);
	parse_arg(ny, argv[2]);
	parse_arg(nt, argv[3]);

	real mu = real_rand();
	real epsilon = real_rand();

	printf("mu = %f, epsilon = %f\n", mu, epsilon);

	size_t szarray = (size_t)nx * ny;
	size_t szarrayb = szarray * sizeof(real);

	typedef real* E[2];
	E e0;
	e0[0] = (real*)memalign(MEMALIGN, szarrayb);
	e0[1] = (real*)memalign(MEMALIGN, szarrayb);
	E e1;
	e1[0] = (real*)memalign(MEMALIGN, szarrayb);
	e1[1] = (real*)memalign(MEMALIGN, szarrayb);
	real* h0 = (real*)memalign(MEMALIGN, szarrayb);
	real* h1 = (real*)memalign(MEMALIGN, szarrayb);
	real* u_em0 = (real*)memalign(MEMALIGN, szarrayb);
	real* u_em1 = (real*)memalign(MEMALIGN, szarrayb);
	real* ca = (real*)memalign(MEMALIGN, szarrayb);
	real* cb = (real*)memalign(MEMALIGN, szarrayb);
	real* da = (real*)memalign(MEMALIGN, szarrayb);
	real* db = (real*)memalign(MEMALIGN, szarrayb);
	real *e0_0 = NULL;
	real *e0_1 = NULL;
	real *e1_0 = NULL;
	real *e1_1 = NULL;

	if (!e0[0] || !e0[1] || !e1[0] || !e1[1] || !h0 || !h1 || !u_em0 || !u_em1 || !ca || !cb || !da || !db)
	{
		printf("Error allocating memory for arrays: %p, %p, %p, %p, %p, %p, %p, %p, %p, %p\n",
			e0[0], e0[1], e1[0], e1[1], h0, h1, u_em0, u_em1, ca, cb, da, db);
		exit(1);
	}

	real mean = 0.0f;
	for (int i = 0; i < szarray; i++)
	{
		e0[0][i] = real_rand();
		e0[1][i] = real_rand();
		e1[0][i] = real_rand();
		e1[1][i] = real_rand();
		h0[i] = real_rand();
		h1[i] = real_rand();
		u_em0[i] = real_rand();
		u_em1[i] = real_rand();
		ca[i] = real_rand();
		cb[i] = real_rand();
		da[i] = real_rand();
		db[i] = real_rand();
		mean += e0[0][i] + e0[1][i] + e1[0][i] + e1[1][i] + h0[i] + h1[i] + u_em0[i] + u_em1[i] + ca[i] + cb[i] + da[i] + db[i];
	}
	printf("initial mean = %f\n", mean / szarray / 12);

	//
	// MIC or OPENACC:
	//
	// 1) Perform an empty offload, that should strip
	// the initialization time from further offloads.
	//
#if defined(_MIC) || defined(_OPENACC)
	volatile struct timespec init_s, init_f;
#if defined(_MIC)
	get_time(&init_s);
	#pragma offload target(mic) \
		nocopy(e0[0]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e0[1]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e1[0]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e1[1]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(h0:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(h1:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(u_em0:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(u_em1:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(ca:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(cb:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(da:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(db:length(szarray) alloc_if(0) free_if(0))
	{ }
	get_time(&init_f);
#endif
#if defined(_OPENACC)
	get_time(&init_s);
	acc_init(acc_device_default);
	get_time(&init_f);
#endif
	double init_t = get_time_diff((struct timespec*)&init_s, (struct timespec*)&init_f);
	if (!no_timing) printf("init time = %f sec\n", init_t);
#endif

	volatile struct timespec total_s, total_f;
	get_time(&total_s);
	//
	// MIC or OPENACC:
	//
	// 2) Allocate data on device, but do not copy anything.
	//
#if defined(_MIC) || defined(_OPENACC)
	volatile struct timespec alloc_s, alloc_f;
#if defined(_MIC)
	get_time(&alloc_s);
	#pragma offload target(mic) \
		nocopy(e0[0]:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(e0[1]:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(e1[0]:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(e1[1]:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(h0:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(h1:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(u_em0:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(u_em1:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(ca:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(cb:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(da:length(szarray) alloc_if(1) free_if(0)), \
		nocopy(db:length(szarray) alloc_if(1) free_if(0))
	{ }
	get_time(&alloc_f);
#endif
#if defined(_OPENACC)
	get_time(&alloc_s);
	e0_0 = e0[0];
	e0_1 = e0[1];
	e1_0 = e1[0];
	e1_1 = e1[1];
	#pragma acc data create (e0_0[0:szarray], e0_1[0:szarray], e1_0[0:szarray], e1_1[0:szarray], h0[0:szarray], h1[0:szarray], u_em0[0:szarray], u_em1[0:szarray], ca[0:szarray], cb[0:szarray], da[0:szarray], db[0:szarray])
	{
	get_time(&alloc_f);
#endif
	double alloc_t = get_time_diff((struct timespec*)&alloc_s, (struct timespec*)&alloc_f);
	if (!no_timing) printf("device buffer alloc time = %f sec\n", alloc_t);
#endif

	//
	// MIC or OPENACC:
	//
	// 3) Transfer data from host to device and leave it there,
	// i.e. do not allocate deivce memory buffers.
	//
#if defined(_MIC) || defined(_OPENACC)
	volatile struct timespec load_s, load_f;
#if defined(_MIC)
	get_time(&load_s);
	#pragma offload target(mic) \
		in(e0[0]:length(szarray) alloc_if(0) free_if(0)), \
		in(e0[1]:length(szarray) alloc_if(0) free_if(0)), \
		in(e1[0]:length(szarray) alloc_if(0) free_if(0)), \
		in(e1[1]:length(szarray) alloc_if(0) free_if(0)), \
		in(h0:length(szarray) alloc_if(0) free_if(0)), \
		in(h1:length(szarray) alloc_if(0) free_if(0)), \
		in(u_em0:length(szarray) alloc_if(0) free_if(0)), \
		in(u_em1:length(szarray) alloc_if(0) free_if(0)), \
		in(ca:length(szarray) alloc_if(0) free_if(0)), \
		in(cb:length(szarray) alloc_if(0) free_if(0)), \
		in(da:length(szarray) alloc_if(0) free_if(0)), \
		in(db:length(szarray) alloc_if(0) free_if(0))
	{ }
	get_time(&load_f);
#endif
#if defined(_OPENACC)
	get_time(&load_s);
	e0_0 = e0[0];
	e0_1 = e0[1];
	e1_0 = e1[0];
	e1_1 = e1[1];
	#pragma acc update device(e0_0[0:szarray], e0_1[0:szarray], e1_0[0:szarray], e1_1[0:szarray], h0[0:szarray], h1[0:szarray], u_em0[0:szarray], u_em1[0:szarray], ca[0:szarray], cb[0:szarray], da[0:szarray], db[0:szarray])
	get_time(&load_f);
#endif
	double load_t = get_time_diff((struct timespec*)&load_s, (struct timespec*)&load_f);
	if (!no_timing) printf("data load time = %f sec (%f GB/sec)\n", load_t, 10 * szarrayb / (load_t * 1024 * 1024 * 1024));
#endif

	//
	// 4) Perform data processing iterations, keeping all data
	// on device.
	//
	int idxs[] = { 0, 1 };
	volatile struct timespec compute_s, compute_f;
	get_time(&compute_s);
#if defined(_MIC)
	#pragma offload target(mic) \
		nocopy(e0[0]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e0[1]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e1[0]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(e1[1]:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(h0:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(h1:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(u_em0:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(u_em1:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(ca:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(cb:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(da:length(szarray) alloc_if(0) free_if(0)), \
		nocopy(db:length(szarray) alloc_if(0) free_if(0))
#endif
	{
		E *e0p = &e0, *e1p = &e1;
		real *h0p = h0, *h1p = h1;
		real *u_em0p = u_em0, *u_em1p = u_em1;
		
		for (int it = 0; it < nt; it++)
		{
			whispering(nx, ny, mu, epsilon, *e0p, *e1p, h0p, h1p, u_em0p, u_em1p, ca, cb, da, db);
			E *e = e0p; e0p = e1p; e1p = e;
			real* h = h0p; h0p = h1p; h1p = h;
			real* u_em = u_em0p; u_em0p = u_em1p; u_em1p = u_em;
			int idx = idxs[0]; idxs[0] = idxs[1]; idxs[1] = idx;
		}
	}
	get_time(&compute_f);
	double compute_t = get_time_diff((struct timespec*)&compute_s, (struct timespec*)&compute_f);
	if (!no_timing) printf("compute time = %f sec\n", compute_t);

	E e[] = { { e0[0], e0[1] }, { e1[0], e1[1] } }; 
	e0[0] = e[idxs[0]][0]; e0[1] = e[idxs[0]][1];
	e1[0] = e[idxs[1]][0]; e1[1] = e[idxs[1]][1];
	real* h[] = { h0, h1 };
	h0 = h[idxs[0]]; h1 = h[idxs[1]];
	real* u_em[] = { u_em0, u_em1 };
	u_em0 = u_em[idxs[0]]; u_em1 = u_em[idxs[1]];

	//
	// MIC or OPENACC:
	//
	// 5) Transfer output data back from device to host.
	//
#if defined(_MIC) || defined(_OPENACC)
	volatile struct timespec save_s, save_f;
#if defined(_MIC)
	get_time(&save_s);
	#pragma offload target(mic) \
		out(e0[0]:length(szarray) alloc_if(0) free_if(0)), \
		out(e0[1]:length(szarray) alloc_if(0) free_if(0)), \
		out(e1[0]:length(szarray) alloc_if(0) free_if(0)), \
		out(e1[1]:length(szarray) alloc_if(0) free_if(0)), \
		out(h0:length(szarray) alloc_if(0) free_if(0)), \
		out(h1:length(szarray) alloc_if(0) free_if(0)), \
		out(u_em0:length(szarray) alloc_if(0) free_if(0)), \
		out(u_em1:length(szarray) alloc_if(0) free_if(0)), \
		out(ca:length(szarray) alloc_if(0) free_if(0)), \
		out(cb:length(szarray) alloc_if(0) free_if(0)), \
		out(da:length(szarray) alloc_if(0) free_if(0)), \
		out(db:length(szarray) alloc_if(0) free_if(0))
	{ }
	get_time(&save_f);
#endif
#if defined(_OPENACC)
	get_time(&save_s);
	e0_0 = e0[0];
	e0_1 = e0[1];
	e1_0 = e1[0];
	e1_1 = e1[1];
#pragma acc update host (e0_0[0:szarray], e0_1[0:szarray], e1_0[0:szarray], e1_1[0:szarray], h0[0:szarray], h1[0:szarray], u_em0[0:szarray], u_em1[0:szarray], ca[0:szarray], cb[0:szarray], da[0:szarray], db[0:szarray])
	get_time(&save_f);
#endif
	double save_t = get_time_diff((struct timespec*)&save_s, (struct timespec*)&save_f);
	if (!no_timing) printf("data save time = %f sec (%f GB/sec)\n", save_t, 10 * szarrayb / (save_t * 1024 * 1024 * 1024));
#endif

	//
	// MIC or OPENACC:
	//
	// 6) Deallocate device data buffers.
	// OPENACC does not seem to have explicit deallocation.
	//
#if defined(_OPENACC)
	}
#endif
#if defined(_MIC)
	volatile struct timespec free_s, free_f;
	get_time(&free_s);
	#pragma offload target(mic) \
		nocopy(e0[0]:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(e0[1]:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(e1[0]:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(e1[1]:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(h0:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(h1:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(u_em0:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(u_em1:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(ca:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(cb:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(da:length(szarray) alloc_if(0) free_if(1)), \
		nocopy(db:length(szarray) alloc_if(0) free_if(1))
	{ }
	get_time(&free_f);
	double free_t = get_time_diff((struct timespec*)&free_s, (struct timespec*)&free_f);
	// if (!no_timing) printf("device buffer free time = %f sec\n", free_t);
#endif

	get_time(&total_f);
	if (!no_timing) printf("device buffer free time = %f sec\n", get_time_diff((struct timespec*)&total_s, (struct timespec*)&total_f));

	// For the final mean - account only the norm of the top
	// most level (tracked by swapping idxs array of indexes).
	mean = 0.0f;
	for (int i = 0; i < szarray; i++)
	{
		mean += e1[0][i] + e1[1][i] + h1[i] + u_em1[i];
	}
	printf("final mean = %f\n", mean / szarray / 4);

	free(e0[0]);
	free(e0[1]);
	free(e1[0]);
	free(e1[1]);
	free(h0);
	free(h1);
	free(u_em0);
	free(u_em1);
	free(ca);
	free(cb);
	free(da);
	free(db);

	fflush(stdout);

	return 0;
}

