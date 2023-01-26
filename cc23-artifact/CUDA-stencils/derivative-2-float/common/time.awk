#!/bin/bash
set -e

echo "-------------------- NVCC ---------------------"

mtime=`grep -E 'float|double' nvcc-orig-results | awk 'BEGIN {mtime = 0.0} {mtime += $2} END {print mtime}'`
awk -v omtime=$mtime 'BEGIN {print "Original GFlops = " (300*300*300*486/10^6/omtime)}'

mtimea=`grep -E 'float|double' nvcc-max-reorder-results-a | awk 'BEGIN {mtimea = 0.0} {mtimea += $2} END {print mtimea}'`
mtimeb=`grep -E 'float|double' nvcc-max-reorder-results-b | awk 'BEGIN {mtimeb = 0.0} {mtimeb += $2} END {print mtimeb}'`
mtimec=`grep -E 'float|double' nvcc-max-reorder-results-c | awk 'BEGIN {mtimec = 0.0} {mtimec += $2} END {print mtimec}'`
mtimed=`grep -E 'float|double' nvcc-max-reorder-results-d | awk 'BEGIN {mtimed = 0.0} {mtimed += $2} END {print mtimed}'`
mtimee=`grep -E 'float|double' nvcc-max-reorder-results-e | awk 'BEGIN {mtimee = 0.0} {mtimee += $2} END {print mtimee}'`
mtimef=`grep -E 'float|double' nvcc-max-reorder-results-f | awk 'BEGIN {mtimef = 0.0} {mtimef += $2} END {print mtimef}'`
mtimeg=`grep -E 'float|double' nvcc-max-reorder-results-g | awk 'BEGIN {mtimeg = 0.0} {mtimeg += $2} END {print mtimeg}'`
mtimeh=`grep -E 'float|double' nvcc-max-reorder-results-h | awk 'BEGIN {mtimeh = 0.0} {mtimeh += $2} END {print mtimeh}'`
mtimei=`grep -E 'float|double' nvcc-max-reorder-results-i | awk 'BEGIN {mtimei = 0.0} {mtimei += $2} END {print mtimei}'`
mtimej=`grep -E 'float|double' nvcc-max-reorder-results-j | awk 'BEGIN {mtimej = 0.0} {mtimej += $2} END {print mtimej}'`
mtimek=`grep -E 'float|double' nvcc-max-reorder-results-k | awk 'BEGIN {mtimek = 0.0} {mtimek += $2} END {print mtimek}'`
mtimel=`grep -E 'float|double' nvcc-max-reorder-results-l | awk 'BEGIN {mtimel = 0.0} {mtimel += $2} END {print mtimel}'`
timea=`grep -E 'float|double' nvcc-reorder-results-a | awk 'BEGIN {timea = 0.0} {timea += $2} END {print timea}'`
timeb=`grep -E 'float|double' nvcc-reorder-results-b | awk 'BEGIN {timeb = 0.0} {timeb += $2} END {print timeb}'`
timec=`grep -E 'float|double' nvcc-reorder-results-c | awk 'BEGIN {timec = 0.0} {timec += $2} END {print timec}'`
timed=`grep -E 'float|double' nvcc-reorder-results-d | awk 'BEGIN {timed = 0.0} {timed += $2} END {print timed}'`
timee=`grep -E 'float|double' nvcc-reorder-results-e | awk 'BEGIN {timee = 0.0} {timee += $2} END {print timee}'`
timef=`grep -E 'float|double' nvcc-reorder-results-f | awk 'BEGIN {timef = 0.0} {timef += $2} END {print timef}'`
timeg=`grep -E 'float|double' nvcc-reorder-results-g | awk 'BEGIN {timeg = 0.0} {timeg += $2} END {print timeg}'`
timeh=`grep -E 'float|double' nvcc-reorder-results-h | awk 'BEGIN {timeh = 0.0} {timeh += $2} END {print timeh}'`
timei=`grep -E 'float|double' nvcc-reorder-results-i | awk 'BEGIN {timei = 0.0} {timei += $2} END {print timei}'`
timej=`grep -E 'float|double' nvcc-reorder-results-j | awk 'BEGIN {timej = 0.0} {timej += $2} END {print timej}'`
timek=`grep -E 'float|double' nvcc-reorder-results-k | awk 'BEGIN {timek = 0.0} {timek += $2} END {print timek}'`
timel=`grep -E 'float|double' nvcc-reorder-results-l | awk 'BEGIN {timel = 0.0} {timel += $2} END {print timel}'`

min1=`awk -v amtime=$mtimea -v bmtime=$mtimeb 'BEGIN {print (amtime<bmtime?amtime:bmtime)}'`
min2=`awk -v min=$min1 -v cmtime=$mtimec 'BEGIN {print (cmtime<min?cmtime:min)}'`
min3=`awk -v min=$min2 -v dmtime=$mtimed 'BEGIN {print (dmtime<min?dmtime:min)}'`
min4=`awk -v min=$min3 -v emtime=$mtimee 'BEGIN {print (emtime<min?emtime:min)}'`
min5=`awk -v min=$min4 -v fmtime=$mtimef 'BEGIN {print (fmtime<min?fmtime:min)}'`
min6=`awk -v min=$min5 -v gmtime=$mtimeg 'BEGIN {print (gmtime<min?gmtime:min)}'`
min7=`awk -v min=$min6 -v hmtime=$mtimeh 'BEGIN {print (hmtime<min?hmtime:min)}'`
min8=`awk -v min=$min7 -v imtime=$mtimei 'BEGIN {print (imtime<min?imtime:min)}'`
min9=`awk -v min=$min8 -v jmtime=$mtimej 'BEGIN {print (jmtime<min?jmtime:min)}'`
min10=`awk -v min=$min9 -v kmtime=$mtimek 'BEGIN {print (kmtime<min?kmtime:min)}'`
mina=`awk -v min=$min10 -v lmtime=$mtimel 'BEGIN {print (lmtime<min?lmtime:min)}'`
min1=`awk -v atime=$timea -v btime=$timeb 'BEGIN {print (atime<btime?atime:btime)}'`
min2=`awk -v min=$min1 -v ctime=$timec 'BEGIN {print (ctime<min?ctime:min)}'`
min3=`awk -v min=$min2 -v dtime=$timed 'BEGIN {print (dtime<min?dtime:min)}'`
min4=`awk -v min=$min3 -v etime=$timee 'BEGIN {print (etime<min?etime:min)}'`
min5=`awk -v min=$min4 -v ftime=$timef 'BEGIN {print (ftime<min?ftime:min)}'`
min6=`awk -v min=$min5 -v gtime=$timeg 'BEGIN {print (gtime<min?gtime:min)}'`
min7=`awk -v min=$min6 -v htime=$timeh 'BEGIN {print (htime<min?htime:min)}'`
min8=`awk -v min=$min7 -v itime=$timei 'BEGIN {print (itime<min?itime:min)}'`
min9=`awk -v min=$min8 -v jtime=$timej 'BEGIN {print (jtime<min?jtime:min)}'`
min10=`awk -v min=$min9 -v ktime=$timek 'BEGIN {print (ktime<min?ktime:min)}'`
minb=`awk -v min=$min10 -v ltime=$timel 'BEGIN {print (ltime<min?ltime:min)}'`
awk -v amin=$mina -v bmin=$minb 'BEGIN {print "Reordered GFlops = " (300*300*300*486/10^6/(amin<bmin?amin:bmin))}'

echo "-------------------- LLVM ---------------------"

mtime=`grep -E 'float|double' llvm-orig-results | awk 'BEGIN {mtime = 0.0} {mtime += $2} END {print mtime}'`
awk -v omtime=$mtime 'BEGIN {print "Original GFlops = " (300*300*300*486/10^6/omtime)}'

mtimea=`grep -E 'float|double' llvm-max-reorder-results-a | awk 'BEGIN {mtimea = 0.0} {mtimea += $2} END {print mtimea}'`
mtimeb=`grep -E 'float|double' llvm-max-reorder-results-b | awk 'BEGIN {mtimeb = 0.0} {mtimeb += $2} END {print mtimeb}'`
mtimec=`grep -E 'float|double' llvm-max-reorder-results-c | awk 'BEGIN {mtimec = 0.0} {mtimec += $2} END {print mtimec}'`
mtimed=`grep -E 'float|double' llvm-max-reorder-results-d | awk 'BEGIN {mtimed = 0.0} {mtimed += $2} END {print mtimed}'`
mtimee=`grep -E 'float|double' llvm-max-reorder-results-e | awk 'BEGIN {mtimee = 0.0} {mtimee += $2} END {print mtimee}'`
mtimef=`grep -E 'float|double' llvm-max-reorder-results-f | awk 'BEGIN {mtimef = 0.0} {mtimef += $2} END {print mtimef}'`
mtimeg=`grep -E 'float|double' llvm-max-reorder-results-g | awk 'BEGIN {mtimeg = 0.0} {mtimeg += $2} END {print mtimeg}'`
mtimeh=`grep -E 'float|double' llvm-max-reorder-results-h | awk 'BEGIN {mtimeh = 0.0} {mtimeh += $2} END {print mtimeh}'`
mtimei=`grep -E 'float|double' llvm-max-reorder-results-i | awk 'BEGIN {mtimei = 0.0} {mtimei += $2} END {print mtimei}'`
mtimej=`grep -E 'float|double' llvm-max-reorder-results-j | awk 'BEGIN {mtimej = 0.0} {mtimej += $2} END {print mtimej}'`
mtimek=`grep -E 'float|double' llvm-max-reorder-results-k | awk 'BEGIN {mtimek = 0.0} {mtimek += $2} END {print mtimek}'`
mtimel=`grep -E 'float|double' llvm-max-reorder-results-l | awk 'BEGIN {mtimel = 0.0} {mtimel += $2} END {print mtimel}'`
timea=`grep -E 'float|double' llvm-reorder-results-a | awk 'BEGIN {timea = 0.0} {timea += $2} END {print timea}'`
timeb=`grep -E 'float|double' llvm-reorder-results-b | awk 'BEGIN {timeb = 0.0} {timeb += $2} END {print timeb}'`
timec=`grep -E 'float|double' llvm-reorder-results-c | awk 'BEGIN {timec = 0.0} {timec += $2} END {print timec}'`
timed=`grep -E 'float|double' llvm-reorder-results-d | awk 'BEGIN {timed = 0.0} {timed += $2} END {print timed}'`
timee=`grep -E 'float|double' llvm-reorder-results-e | awk 'BEGIN {timee = 0.0} {timee += $2} END {print timee}'`
timef=`grep -E 'float|double' llvm-reorder-results-f | awk 'BEGIN {timef = 0.0} {timef += $2} END {print timef}'`
timeg=`grep -E 'float|double' llvm-reorder-results-g | awk 'BEGIN {timeg = 0.0} {timeg += $2} END {print timeg}'`
timeh=`grep -E 'float|double' llvm-reorder-results-h | awk 'BEGIN {timeh = 0.0} {timeh += $2} END {print timeh}'`
timei=`grep -E 'float|double' llvm-reorder-results-i | awk 'BEGIN {timei = 0.0} {timei += $2} END {print timei}'`
timej=`grep -E 'float|double' llvm-reorder-results-j | awk 'BEGIN {timej = 0.0} {timej += $2} END {print timej}'`
timek=`grep -E 'float|double' llvm-reorder-results-k | awk 'BEGIN {timek = 0.0} {timek += $2} END {print timek}'`
timel=`grep -E 'float|double' llvm-reorder-results-l | awk 'BEGIN {timel = 0.0} {timel += $2} END {print timel}'`

min1=`awk -v amtime=$mtimea -v bmtime=$mtimeb 'BEGIN {print (amtime<bmtime?amtime:bmtime)}'`
min2=`awk -v min=$min1 -v cmtime=$mtimec 'BEGIN {print (cmtime<min?cmtime:min)}'`
min3=`awk -v min=$min2 -v dmtime=$mtimed 'BEGIN {print (dmtime<min?dmtime:min)}'`
min4=`awk -v min=$min3 -v emtime=$mtimee 'BEGIN {print (emtime<min?emtime:min)}'`
min5=`awk -v min=$min4 -v fmtime=$mtimef 'BEGIN {print (fmtime<min?fmtime:min)}'`
min6=`awk -v min=$min5 -v gmtime=$mtimeg 'BEGIN {print (gmtime<min?gmtime:min)}'`
min7=`awk -v min=$min6 -v hmtime=$mtimeh 'BEGIN {print (hmtime<min?hmtime:min)}'`
min8=`awk -v min=$min7 -v imtime=$mtimei 'BEGIN {print (imtime<min?imtime:min)}'`
min9=`awk -v min=$min8 -v jmtime=$mtimej 'BEGIN {print (jmtime<min?jmtime:min)}'`
min10=`awk -v min=$min9 -v kmtime=$mtimek 'BEGIN {print (kmtime<min?kmtime:min)}'`
mina=`awk -v min=$min10 -v lmtime=$mtimel 'BEGIN {print (lmtime<min?lmtime:min)}'`
min1=`awk -v atime=$timea -v btime=$timeb 'BEGIN {print (atime<btime?atime:btime)}'`
min2=`awk -v min=$min1 -v ctime=$timec 'BEGIN {print (ctime<min?ctime:min)}'`
min3=`awk -v min=$min2 -v dtime=$timed 'BEGIN {print (dtime<min?dtime:min)}'`
min4=`awk -v min=$min3 -v etime=$timee 'BEGIN {print (etime<min?etime:min)}'`
min5=`awk -v min=$min4 -v ftime=$timef 'BEGIN {print (ftime<min?ftime:min)}'`
min6=`awk -v min=$min5 -v gtime=$timeg 'BEGIN {print (gtime<min?gtime:min)}'`
min7=`awk -v min=$min6 -v htime=$timeh 'BEGIN {print (htime<min?htime:min)}'`
min8=`awk -v min=$min7 -v itime=$timei 'BEGIN {print (itime<min?itime:min)}'`
min9=`awk -v min=$min8 -v jtime=$timej 'BEGIN {print (jtime<min?jtime:min)}'`
min10=`awk -v min=$min9 -v ktime=$timek 'BEGIN {print (ktime<min?ktime:min)}'`
minb=`awk -v min=$min10 -v ltime=$timel 'BEGIN {print (ltime<min?ltime:min)}'`
awk -v amin=$mina -v bmin=$minb 'BEGIN {print "Reordered GFlops = " (300*300*300*486/10^6/(amin<bmin?amin:bmin))}'
