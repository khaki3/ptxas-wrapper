#!/bin/bash
set -e

echo "-------------------- NVCC ---------------------"

time=`grep -E 'float|double' nvcc-orig-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
awk -v otime=$time 'BEGIN {print "Original GFlops = " (300*300*300*687/10^6/otime)}'

time0=`grep -E 'float|double' nvcc-reorder-results | awk 'BEGIN {time0 = 0.0} {time0 += $2} END {print time0}'`
timea=`grep -E 'float|double' nvcc-reorder-results-a | awk 'BEGIN {timea = 0.0} {timea += $2} END {print timea}'`
timeb=`grep -E 'float|double' nvcc-reorder-results-b | awk 'BEGIN {timeb = 0.0} {timeb += $2} END {print timeb}'`
timee=`grep -E 'float|double' nvcc-reorder-results-e | awk 'BEGIN {timee = 0.0} {timee += $2} END {print timee}'`
timef=`grep -E 'float|double' nvcc-reorder-results-f | awk 'BEGIN {timef = 0.0} {timef += $2} END {print timef}'`
timeg=`grep -E 'float|double' nvcc-reorder-results-g | awk 'BEGIN {timeg = 0.0} {timeg += $2} END {print timeg}'`
timeh=`grep -E 'float|double' nvcc-reorder-results-h | awk 'BEGIN {timeh = 0.0} {timeh += $2} END {print timeh}'`
timei=`grep -E 'float|double' nvcc-reorder-results-i | awk 'BEGIN {timei = 0.0} {timei += $2} END {print timei}'`
timej=`grep -E 'float|double' nvcc-reorder-results-j | awk 'BEGIN {timej = 0.0} {timej += $2} END {print timej}'`
timek=`grep -E 'float|double' nvcc-reorder-results-k | awk 'BEGIN {timek = 0.0} {timek += $2} END {print timek}'`
timel=`grep -E 'float|double' nvcc-reorder-results-l | awk 'BEGIN {timel = 0.0} {timel += $2} END {print timel}'`

min1=`awk -v atime=$timea -v btime=$timeb 'BEGIN {print (atime<btime?atime:btime)}'`
min2=`awk -v min=$min1 -v time=$time0 'BEGIN {print (time<min?time:min)}'`
min4=`awk -v min=$min2 -v etime=$timee 'BEGIN {print (etime<min?etime:min)}'`
min5=`awk -v min=$min4 -v ftime=$timef 'BEGIN {print (ftime<min?ftime:min)}'`
min6=`awk -v min=$min5 -v gtime=$timeg 'BEGIN {print (gtime<min?gtime:min)}'`
min7=`awk -v min=$min6 -v htime=$timeh 'BEGIN {print (htime<min?htime:min)}'`
min8=`awk -v min=$min7 -v itime=$timei 'BEGIN {print (itime<min?itime:min)}'`
min9=`awk -v min=$min8 -v jtime=$timej 'BEGIN {print (jtime<min?jtime:min)}'`
min10=`awk -v min=$min9 -v ktime=$timek 'BEGIN {print (ktime<min?ktime:min)}'`
awk -v min=$min10 -v ltime=$timel 'BEGIN {print "Reordered GFlops = " (300*300*300*687/10^6/(min<ltime?min:ltime))}'

echo "-------------------- LLVM ---------------------"

time=`grep -E 'float|double' llvm-orig-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
awk -v otime=$time 'BEGIN {print "Original GFlops = " (300*300*300*687/10^6/otime)}'

time0=`grep -E 'float|double' llvm-reorder-results | awk 'BEGIN {timea = 0.0} {time0 += $2} END {print time0}'`
timea=`grep -E 'float|double' llvm-reorder-results-a | awk 'BEGIN {timea = 0.0} {timea += $2} END {print timea}'`
timeb=`grep -E 'float|double' llvm-reorder-results-b | awk 'BEGIN {timeb = 0.0} {timeb += $2} END {print timeb}'`
timee=`grep -E 'float|double' llvm-reorder-results-e | awk 'BEGIN {timee = 0.0} {timee += $2} END {print timee}'`
timef=`grep -E 'float|double' llvm-reorder-results-f | awk 'BEGIN {timef = 0.0} {timef += $2} END {print timef}'`
timeg=`grep -E 'float|double' llvm-reorder-results-g | awk 'BEGIN {timeg = 0.0} {timeg += $2} END {print timeg}'`
timeh=`grep -E 'float|double' llvm-reorder-results-h | awk 'BEGIN {timeh = 0.0} {timeh += $2} END {print timeh}'`
timei=`grep -E 'float|double' llvm-reorder-results-i | awk 'BEGIN {timei = 0.0} {timei += $2} END {print timei}'`
timej=`grep -E 'float|double' llvm-reorder-results-j | awk 'BEGIN {timej = 0.0} {timej += $2} END {print timej}'`
timek=`grep -E 'float|double' llvm-reorder-results-k | awk 'BEGIN {timek = 0.0} {timek += $2} END {print timek}'`
timel=`grep -E 'float|double' llvm-reorder-results-l | awk 'BEGIN {timel = 0.0} {timel += $2} END {print timel}'`

min1=`awk -v atime=$timea -v btime=$timeb 'BEGIN {print (atime<btime?atime:btime)}'`
min2=`awk -v min=$min1 -v time=$time0 'BEGIN {print (time<min?time:min)}'`
min4=`awk -v min=$min2 -v etime=$timee 'BEGIN {print (etime<min?etime:min)}'`
min5=`awk -v min=$min4 -v ftime=$timef 'BEGIN {print (ftime<min?ftime:min)}'`
min6=`awk -v min=$min5 -v gtime=$timeg 'BEGIN {print (gtime<min?gtime:min)}'`
min7=`awk -v min=$min6 -v htime=$timeh 'BEGIN {print (htime<min?htime:min)}'`
min8=`awk -v min=$min7 -v itime=$timei 'BEGIN {print (itime<min?itime:min)}'`
min9=`awk -v min=$min8 -v jtime=$timej 'BEGIN {print (jtime<min?jtime:min)}'`
min10=`awk -v min=$min9 -v ktime=$timek 'BEGIN {print (ktime<min?ktime:min)}'`
awk -v min=$min10 -v ltime=$timel 'BEGIN {print "Reordered GFlops = " (300*300*300*687/10^6/(min<ltime?min:ltime))}'
