import numpy as np
import sys
import re
import glob

def error(msg):
    print(msg)
    sys.exit(-1)

if len(sys.argv)!=2:
    error("Usage: %s directory-containing-log-files" % sys.argv[0])

def find_log(sym):
    a = glob.glob(sys.argv[1] + "/" + sym + ".*.log")
    return a[0] if a else None

def extract_bench_name(log):
    r=[]
    for line in open(log).readlines():
        m = re.match('^== ([^ ]*) (.*)', line)
        if m:
            r.append(m.group(1))
    return r

def extract_compute_time(log):
    r=[]
    for line in open(log).readlines():
        m = re.match('^compute time = (.*) sec', line)
        if m:
            r.append(float(m.group(1)))
    # tricubic
    r[7]*=3.0/10.0
    r[8]*=3.0/10.0
    return r

def extract_prof_param(log, metric):
    r=[]
    for line in open(log).readlines():
        m = re.match('^.*' + metric + '.*,([^,%]*)%?$', line.rstrip('\n'))
        if m:
            r.append(float(m.group(1)))
    return r

def extract_stall_memdep(log):
    return extract_prof_param(log, 'stall_memory_dependency')

def extract_stall_memthr(log):
    return extract_prof_param(log, 'stall_memory_throttle')

def extract_stall_execdep(log):
    return extract_prof_param(log, 'stall_exec_dependency')

def extract_stall_pipe(log):
    return extract_prof_param(log, 'stall_pipe_busy')

def extract_stall_const(log):
    return extract_prof_param(log, 'constant_memory_dependency')

def extract_stall_inst(log):
    return extract_prof_param(log, 'stall_inst_fetch')

def extract_stall_not(log):
    return extract_prof_param(log, 'stall_not_selected')

def extract_stall_other(log):
    return extract_prof_param(log, 'stall_other')

def extract_stall_sync(log):
    return extract_prof_param(log, 'stall_sync')

def extract_stall_texture(log):
    return extract_prof_param(log, 'stall_texture')

def extract_register(log):
    r=[]
    for line in open(log).readlines():
        m = re.match('^.*Used (.*) registers.*$', line)
        if m:
            r.append(float(m.group(1)))
    return r

orig=find_log('ORIGINAL')
norm=find_log('NORMAL')
noload=find_log('NOLOAD')
nocorner=find_log('NOCORNER')

porig=find_log('PROF_ORIGINAL')
pnorm=find_log('PROF_NORMAL')
pnoload=find_log('PROF_NOLOAD')
pnocorner=find_log('PROF_NOCORNER')

if not orig or not norm or not noload or not nocorner:
    error("Error: Log not found")

co=np.array(extract_compute_time(orig))
cn=np.array(extract_compute_time(norm))
cl=np.array(extract_compute_time(noload))
cc=np.array(extract_compute_time(nocorner))

fo=1/co
fn=1/cn
fl=1/cl
fc=1/cc
names=extract_bench_name(orig)

improvement=(fn-fo)/fo

print(names)
print(fo)
print(fn)
print("improvement:")
print(improvement)

print(max(improvement))
print((improvement>0).sum())

print("speedup")
print(fl/fo)
print(fc/fo)
print(fn/fo)
# print('==pred')
# print((1/np.array(extract_compute_time(find_log('NORMALPRED'))))/fn)
# print(np.average((1/np.array(extract_compute_time(find_log('NORMALPRED'))))/fn))
# print('==')

print(np.average(improvement))
print(np.average(fn/fo)-1)

ro=np.array(extract_register(orig))
rn=np.array(extract_register(norm))
rl=np.array(extract_register(noload))
rc=np.array(extract_register(nocorner))

print(ro)
print(rl)
print(rc)
print(rn)
print(rn-ro)

print(np.average(ro))
print(np.average(rl-ro))
print(np.average(rc-ro))
print(np.average(rn-ro))


so=np.array(extract_stall_execdep(porig))
sn=np.array(extract_stall_execdep(pnorm))
sl=np.array(extract_stall_execdep(pnoload))
sc=np.array(extract_stall_execdep(pnocorner))

po=np.array(extract_stall_pipe(porig))
pn=np.array(extract_stall_pipe(pnorm))
pl=np.array(extract_stall_pipe(pnoload))
pc=np.array(extract_stall_pipe(pnocorner))

print(np.average(so))
print(np.average(po))

mo=np.array(extract_stall_memdep(porig))
ml=np.array(extract_stall_memdep(pnoload))
to=np.array(extract_stall_memthr(porig))
tl=np.array(extract_stall_memthr(pnoload))

np.set_printoptions(suppress=True)

print(mo)
print(ml)
print(to)
print(tl)
print(to-tl)

print('--')
print(pl)
print(pc)
print('--')
print(pc-pl)
print(sc-sl)
print(np.average(pc-pl))
print(np.average(sc-sl))

print(extract_stall_texture(porig))
print(extract_stall_texture(pnorm))

print(extract_stall_memdep(porig))
print(extract_stall_memdep(pnoload))
