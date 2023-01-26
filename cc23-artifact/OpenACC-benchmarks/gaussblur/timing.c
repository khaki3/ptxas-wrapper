//===----------------------------------------------------------------------===//
//
//     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
//        compiler for NVIDIA GPUs, targeting numerical modeling code.
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "timing.h"

#include <stdio.h>
#include <time.h>

#define CLOCKID CLOCK_REALTIME

// Get the timer resolution.
void get_timer_resolution(struct timespec* val)
{
	clock_getres(CLOCKID, val);
}

// Get the timer value.
void get_time(volatile struct timespec* val)
{
	clock_gettime(CLOCKID, (struct timespec*)val);
}

// Get the timer measured values difference.
double get_time_diff(struct timespec* val1, struct timespec* val2)
{
	int64_t seconds = val2->tv_sec - val1->tv_sec;
	int64_t nanoseconds = val2->tv_nsec - val1->tv_nsec;
	if (val2->tv_nsec < val1->tv_nsec)
	{
		seconds--;
		nanoseconds = (1000000000 - val1->tv_nsec) + val2->tv_nsec;
	}
	
	return (double)0.000000001 * nanoseconds + seconds;
}

// Print the timer measured values difference.
void print_time_diff(struct timespec* val1, struct timespec* val2)
{
	int64_t seconds = val2->tv_sec - val1->tv_sec;
	int64_t nanoseconds = val2->tv_nsec - val1->tv_nsec;
	if (val2->tv_nsec < val1->tv_nsec)
	{
		seconds--;
		nanoseconds = (1000000000 - val1->tv_nsec) + val2->tv_nsec;
	}
	if (sizeof(uint64_t) == sizeof(long))
		printf("%ld.%09ld", (long)seconds, (long)nanoseconds);
	else
		printf("%lld.%09lld", (long long)seconds, (long long)nanoseconds);

}

