import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.ticker as plticker
from matplotlib.ticker import FormatStrFormatter
from matplotlib.colors import colorConverter as cc
import seaborn as sns
import numpy as np
import sys
import os
import re
import glob

#plt.rcParams["font.family"] = "Times New Roman"
plt.rcParams["figure.figsize"] = (6,1.4)
plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble'] = "\\usepackage{libertine}"
plt.rcParams['ps.usedistiller'] = "xpdf"

# plt.rcParams.update({
#     "font.family": "serif",
#     "font.size": 20,
#     'figure.figsize': (5, 3),
#     "text.usetex": True,
#     # 'text.latex.preview': True,
#     'text.latex.preamble': [
#         r""" \usepackage{libertine}
#         \usepackage[libertine]{newtxmath}
#         """]})

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

orig=find_log('PROF_ORIGINAL')
norm=find_log('PROF_NORMAL')
noload=find_log('PROF_NOLOAD')
nocorner=find_log('PROF_NOCORNER')

if not orig or not norm or not noload or not nocorner:
    error("Error: Log not found")

co=np.array(extract_stall_memdep(orig))
cn=np.array(extract_stall_memdep(norm))
cl=np.array(extract_stall_memdep(noload))
cc=np.array(extract_stall_memdep(nocorner))

do=np.array(extract_stall_memthr(orig))
dn=np.array(extract_stall_memthr(norm))
dl=np.array(extract_stall_memthr(noload))
dc=np.array(extract_stall_memthr(nocorner))

eo=np.array(extract_stall_execdep(orig))
en=np.array(extract_stall_execdep(norm))
el=np.array(extract_stall_execdep(noload))
ec=np.array(extract_stall_execdep(nocorner))

po=np.array(extract_stall_pipe(orig))
pn=np.array(extract_stall_pipe(norm))
pl=np.array(extract_stall_pipe(noload))
pc=np.array(extract_stall_pipe(nocorner))

to=np.array(extract_stall_const(orig))
tn=np.array(extract_stall_const(norm))
tl=np.array(extract_stall_const(noload))
tc=np.array(extract_stall_const(nocorner))

so=np.array(extract_stall_inst(orig))
sn=np.array(extract_stall_inst(norm))
sl=np.array(extract_stall_inst(noload))
sc=np.array(extract_stall_inst(nocorner))

no=np.array(extract_stall_not(orig))
nn=np.array(extract_stall_not(norm))
nl=np.array(extract_stall_not(noload))
nc=np.array(extract_stall_not(nocorner))

ro=np.array(extract_stall_other(orig))
rn=np.array(extract_stall_other(norm))
rl=np.array(extract_stall_other(noload))
rc=np.array(extract_stall_other(nocorner))

yo=np.array(extract_stall_sync(orig))
yn=np.array(extract_stall_sync(norm))
yl=np.array(extract_stall_sync(noload))
yc=np.array(extract_stall_sync(nocorner))

xo=np.array(extract_stall_texture(orig))
xn=np.array(extract_stall_texture(norm))
xl=np.array(extract_stall_texture(noload))
xc=np.array(extract_stall_texture(nocorner))


names=extract_bench_name(orig)
xstep=np.arange(len(co))

sns.set_theme()
fig, ax = plt.subplots()

plt.bar(xstep-0.4, 100, color='white', width=0.2, edgecolor='black')
plt.bar(xstep-0.2, 100, color='white', width=0.2, edgecolor='black')
plt.bar(xstep+0,   100, color='white', width=0.2, edgecolor='black')
plt.bar(xstep+0.2, 100, color='white', width=0.2, edgecolor='black')

#color: https://seaborn.pydata.org/tutorial/color_palettes.html
col4="#7bdb57" # memory dep
col3="#db8a57" # memory throttle
col2="#5d57db" # exec dep
col1="#57d3db" # pipe busy
col5="#db57d4" # instruction fetch
col6="#d5db57" # not selected
col7="#db5c57"
col8="white" # other

plt.bar(xstep-0.4, co+do+eo+po+so+no+xo, color=col7, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl+el+pl+sl+nl+xl, color=col7, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc+ec+pc+sc+nc+xc, color=col7, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn+en+pn+sn+nn+xn, color=col7, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co+do+eo+po+so+no, color=col6, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl+el+pl+sl+nl, color=col6, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc+ec+pc+sc+nc, color=col6, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn+en+pn+sn+nn, color=col6, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co+do+eo+po+so, color=col5, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl+el+pl+sl, color=col5, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc+ec+pc+sc, color=col5, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn+en+pn+sn, color=col5, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co+do+eo+po, color=col1, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl+el+pl, color=col1, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc+ec+pc, color=col1, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn+en+pn, color=col1, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co+do+eo, color=col2, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl+el, color=col2, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc+ec, color=col2, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn+en, color=col2, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co+do, color=col3, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl+dl, color=col3, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc+dc, color=col3, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn+dn, color=col3, width=0.165, edgecolor='None')

plt.bar(xstep-0.4, co, color=col4, width=0.165, edgecolor='None')
plt.bar(xstep-0.2, cl, color=col4, width=0.165, edgecolor='None')
plt.bar(xstep+0,   cc, color=col4, width=0.165, edgecolor='None')
plt.bar(xstep+0.2, cn, color=col4, width=0.165, edgecolor='None')

maxval=max(co)
maxval=max(max(cn),maxval)

ax.set_xticks(xstep, [], fontsize=12)
ax.tick_params(axis='y', labelsize=20)
ax.yaxis.set_major_formatter(FormatStrFormatter('%d'))
plt.yticks(np.arange(0, 120, 25))
plt.margins(x=0.01, y=0.05, tight=True)
# plt.ylabel('Stall (\%)', fontsize=22)
plt.ylim([0,110])
 
class LegendObject(object):
    def __init__(self, facecolor='red', edgecolor='white', dashed=False):
        self.facecolor = facecolor
        self.edgecolor = edgecolor
        self.dashed = dashed
 
    def legend_artist(self, legend, orig_handle, fontsize, handlebox):
        x0, y0 = handlebox.xdescent, handlebox.ydescent
        width, height = handlebox.width, handlebox.height
        patch = mpatches.Rectangle(
            # create a rectangle that is filled with color
            [x0, y0], width, height, facecolor=self.facecolor, alpha=0.8,
            # and whose edges are the faded color
            edgecolor=self.edgecolor, lw=2)
        handlebox.add_artist(patch)
 
        # if we're creating the legend for a dashed line,
        # manually add the dash in to our rectangle
        if self.dashed:
            patch1 = mpatches.Rectangle(
                [x0 + 2*width/5, y0], width/5, height, facecolor=self.edgecolor,
                transform=handlebox.get_transform())
            handlebox.add_artist(patch1)
 
        return patch

# plt.legend([0, 1], ['Original', 'PTXAWS'], fontsize=18, ncol=2, loc='upper center',
#         handler_map={
#                0: LegendObject('white', 'gray'),
#                1: LegendObject('black', 'gray'),
#             })

gpuarch=int(os.getenv('GPUARCH'))
if gpuarch==35:
    plt.text(9, 20, "Kepler", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
elif gpuarch==50:
    plt.text(8.5, 20, "Maxwell", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
elif gpuarch==60:
    plt.text(9, 20, "Pascal", bbox=dict(facecolor='white', alpha=0.5), fontsize=24)
else:
    plt.text(9.2, 20, "Volta", bbox=dict(facecolor='white', alpha=0.5), fontsize=24)

plt.tight_layout()
plt.grid(axis='y', linestyle='dashed')
fig.subplots_adjust(
    top=0.97,
    bottom=0.13,
    left=0.155,
    right=0.991,
    # hspace=0.2,
    # wspace=0.2
)
plt.savefig('plot.pdf')
