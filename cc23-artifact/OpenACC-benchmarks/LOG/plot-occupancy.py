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
plt.rcParams["figure.figsize"] = (6,2)
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

def extract_occupancy(log):
    r=[]
    for line in open(log).readlines():
        m = re.match('^.*achieved_occupancy.*,([^,]*)$', line)
        if m:
            r.append(float(m.group(1)))
    return r

def extract_register(log):
    r=[]
    for line in open(log).readlines():
        m = re.match('^.*Used (.*) registers.*$', line)
        if m:
            r.append(float(m.group(1)))
    return r

orig=find_log('PROF_ORIGINAL')
norm=find_log('PROF_NORMAL')
noload=find_log('PROF_NOLOAD')
nocorner=find_log('PROF_NOCORNER')

if not orig or not norm or not noload or not nocorner:
    error("Error: Log not found")

co=np.array(extract_occupancy(orig))
cn=np.array(extract_occupancy(norm))
cl=np.array(extract_occupancy(noload))
cc=np.array(extract_occupancy(nocorner))
ro=np.array(extract_register(orig))
rn=np.array(extract_register(norm))
rl=np.array(extract_register(noload))
rc=np.array(extract_register(nocorner))

names=extract_bench_name(orig)
xstep=np.arange(len(co))

sns.set_theme()
fig, ax = plt.subplots()

ax2 = ax.twinx()


ax.bar(xstep-0.4, co, color='white', alpha=1.0, width=0.2, edgecolor='black')
ax.bar(xstep-0.2, cl, color=(1,0,0,0.5), width=0.2, edgecolor='black')
ax.bar(xstep+0,   cc, color=(0,0,1,0.5), width=0.2, edgecolor='black')
ax.bar(xstep+0.2, cn, color=(0,0,0,0.2), width=0.2, edgecolor='black', hatch='///')

ax2.plot(xstep-0.4, ro, color='black', linewidth=1, ls='--', marker='_', markersize=5, markerfacecolor='w', markeredgewidth=2, markeredgecolor='black')
ax2.plot(xstep-0.2, rl, linestyle='', color=(1,0,0,0.5), marker='_', markersize=5, markerfacecolor=(1,0,0,0.5), markeredgewidth=2, markeredgecolor='black')
ax2.plot(xstep-0  , rc, color=(0,0,1,0.5), linestyle='', marker='_', markersize=5, markerfacecolor=(0,0,1,0.5), markeredgewidth=2, markeredgecolor='black')
ax2.plot(xstep+0.2, rn, color='gray',  linewidth=1, ls='--', marker='_', markerfacecolor=(0,0,0,0.2), markeredgewidth=2, markeredgecolor='black')

maxval=max(co)
maxval=max(max(cn),maxval)

ax.set_xticks(xstep, [], fontsize=12)
ax.tick_params(axis='y', labelsize=20)
ax2.tick_params(axis='y', labelsize=20)
ax.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
ax2.yaxis.set_major_formatter(FormatStrFormatter('%d'))
ax.set_yticks(np.arange(0, 4, 0.25))
ax.set_ylim([0,1.1])
ax2.set_ylim([0,141])
# ax2.set_yticks(np.arange(0, 130, 16))
ax2.set_yticks(np.arange(0, 130, 32))
plt.margins(x=0.01, y=0.05, tight=True)
# ax.set_ylabel('Occupancy', fontsize=22)
# ax2.set_ylabel('\# of Registers', fontsize=22)
 
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

# plt.text(8.5, 110, "Kepler", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
# plt.text(8, 110, "Maxwell", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
# plt.text(8.5, 110, "Pascal", bbox=dict(facecolor='white', alpha=0.5), fontsize=24) 
plt.text(8.7, 110, "Volta", bbox=dict(facecolor='white', alpha=0.5), fontsize=24)

ax.tick_params(axis=u'both', which=u'both',length=0)
ax2.tick_params(axis=u'both', which=u'both',length=0)

plt.tight_layout()
plt.grid(axis='y', linestyle='None')
fig.subplots_adjust(
    top=0.95,
    bottom=0.13,
    left=0.14,
    right=0.87,
    # hspace=0.2,
    # wspace=0.2
)
plt.savefig('plot.pdf')
