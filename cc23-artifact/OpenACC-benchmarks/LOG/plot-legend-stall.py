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
plt.rcParams["figure.figsize"] = (6,0.8)
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

orig=find_log('ORIGINAL')
norm=find_log('NORMAL')

if not orig or not norm:
    error("Error: Log not found")

co=extract_compute_time(orig)
cn=extract_compute_time(norm)

names=extract_bench_name(orig)
xstep=np.arange(len(co))

fig, ax = plt.subplots()
# plt.bar(xstep-0.2, co, color='white', alpha=1.0, width=0.4, edgecolor='black')
# plt.bar(xstep+0.2, cn, color='black', alpha=0.8, width=0.4, edgecolor='black')

maxval=max(co)
maxval=max(max(cn),maxval)

# ax.set_xticks(xstep, names, fontsize=16, rotation=30) # Volta
ax.set_xticks(xstep, [], fontsize=12)
# ax.tick_params(axis='y', labelsize=20)
# ax.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
# plt.yticks(np.arange(0, maxval*1.2, 0.5)) # Kepler, Maxwell
# plt.xticks(ticks=xstep+0.5, labels=names, fontsize=16, rotation=30, ha='right')
# plt.yticks(np.arange(0, maxval*1.2, 0.3)) # Pascal
# plt.yticks(np.arange(0, maxval*1.2, 0.1)) # Volta
plt.margins(x=0.01, y=0.05, tight=True)
# plt.ylabel('Runtime (s)', fontsize=24)

class LegendObject(object):
    def __init__(self, facecolor='red', edgecolor='white', dashed=False, hatch=''):
        self.facecolor = facecolor
        self.edgecolor = edgecolor
        self.dashed = dashed
        self.hatch = hatch
 
    def legend_artist(self, legend, orig_handle, fontsize, handlebox):
        x0, y0 = handlebox.xdescent, handlebox.ydescent
        width, height = handlebox.width, handlebox.height
        patch = mpatches.Rectangle(
            # create a rectangle that is filled with color
            [x0, y0], width, height, facecolor=self.facecolor,
            # and whose edges are the faded color
            edgecolor=self.edgecolor, lw=2, hatch=self.hatch)
        handlebox.add_artist(patch)
 
        # if we're creating the legend for a dashed line,
        # manually add the dash in to our rectangle
        if self.dashed:
            patch1 = mpatches.Rectangle(
                [x0 + 2*width/5, y0], width/5, height, facecolor=self.edgecolor,
                transform=handlebox.get_transform())
            handlebox.add_artist(patch1)
 
        return patch

col4="#7bdb57" # memory dep
col3="#db8a57" # memory throttle
col2="#5d57db" # exec dep
col1="#57d3db" # pipe busy
col5="#db57d4" # instruction fetch
col6="#d5db57" # not selected
col7="#db5c57" # other
col8="white"

col=[col4,col3,col2,col1,col5,col6,col7,col8]

order=[0,4,1,5,2,6,3,7]

#['Memory Dependency', 'Memory Throttle', 'Exec Dependency', 'Pipe Busy', 'Inst Fetch', 'Not Selected', 'Other']
plt.legend([0, 1, 2, 3, 4, 5, 6, 7], [['Mem Dep', 'Mem Throttle', 'Exec Dep', 'Pipe Busy', 'Inst Fetch', 'Not Selected', 'Texture', 'Other'][idx] for idx in order], fontsize=18, ncol=4, bbox_to_anchor=(-1,-2), loc='lower center', columnspacing=1.0, handlelength=1, handletextpad=0.4,
        handler_map={
               0: LegendObject(col[order[0]], 'black'),
               1: LegendObject(col[order[1]], 'black'),
               2: LegendObject(col[order[2]], 'black'),
               3: LegendObject(col[order[3]], 'black'),
               4: LegendObject(col[order[4]], 'black'),
               5: LegendObject(col[order[5]], 'black'),
               6: LegendObject(col[order[6]], 'black'),
               7: LegendObject(col[order[7]], 'black'),
            })

# plt.text(9, 1.9, "Kepler", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
# plt.text(8.5, 1.6, "Maxwell", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
# plt.text(9, 0.75, "Pascal", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
# plt.text(9.2, 0.43, "Volta", bbox=dict(facecolor='white', alpha=0.5), fontsize=24)

plt.tight_layout()
plt.grid(axis='y', linestyle='dashed')
fig.subplots_adjust(
    top=1.3,
    bottom=1.1,
    left=0.0,
    right=1.4,
    # hspace=0.2,
    # wspace=0.2
)
plt.savefig('plot.pdf', bbox_inches='tight')
