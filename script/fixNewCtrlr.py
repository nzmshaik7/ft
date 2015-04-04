#!/usr/bin/python

import sys
import os

srcfn = sys.argv[1]
if not os.path.exists(srcfn):
    print "no file", srcfn
    sys.exit(1)

oldfn = srcfn + ".orig"
os.rename(srcfn, oldfn)

newf = open(srcfn, 'w')
oldf = open(oldfn, 'r')
inCreate = False
inUpdate = False
inIndex = False
act = "?"
for ln in oldf.readlines():
    show = True
    if ln.startswith('class '):
        toks = ln.split()
        cname = toks[1].replace('Controller', '')
    if ln.startswith('    end'):
        inCreate = False
        inUpdate = False
        inIndex = False
    if ln.find('def index') != -1:
        inIndex = True
    if ln.find('def create') != -1:
        inCreate = True
        act = 'created'
    if ln.find('def update') != -1:
        inUpdate = True
        act = 'updated'
    if inCreate or inUpdate:
        dex = ln.find('format.html { redirect_to @')
        if dex != -1:
            dent = ln[0:dex]
            newf.write("%sformat.html { redirect_to %s_url,\n" % (
                                                         dent, cname.lower()))
            newf.write("%s              notice: '%s was " % (dent, mname))
            newf.write("successfully %s.' }\n" % act)
            show = False
    if inIndex and ln.find('.all') != -1:
        toks = ln.strip().split()
        t2 = toks[2].split('.')
        if t2[1] == 'all':
            mname = t2[0]
    if show:
        newf.write(ln)
