//===----------------------------------------------------------------------===//
//
//     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
//        compiler for NVIDIA GPUs, targeting numerical modeling code.
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <stdint.h>
#include <stdio.h>
#include <time.h>

// Get the timer resolution.
void get_timer_resolution(struct timespec* val);

// Get the timer value.
void get_time(volatile struct timespec* val);

// Get the timer measured values difference.
double get_time_diff(struct timespec* val1, struct timespec* val2);

// Print the timer measured values difference.
void print_time_diff(struct timespec* val1, struct timespec* val2);
