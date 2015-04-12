#!/usr/bin/python

import sys
import os
import re

srcfn = sys.argv[1]
if not os.path.exists(srcfn):
    print "no file", srcfn
    sys.exit(1)

# First pass: get url from delete method
oldf = open(srcfn, 'r')
urlRe = re.compile(r'format.html { redirect_to (\w*)')
inDestroy = False
url = None
for ln in oldf.readlines():
    if ln.find('def destroy') != -1:
        inDestroy = True
    if ln.startswith('    end'):
        inDestroy = False
    if inDestroy:
        mo = re.search(urlRe, ln)
        if mo:
            url = mo.group(1)

oldf.close
if not urlRe:
    print "ERROR: Cannot find URL in destroy method"
    sys.exit(2)

oldfn = srcfn + ".orig"
os.rename(srcfn, oldfn)

newf = open(srcfn, 'w')
oldf = open(oldfn, 'r')
inCreate = False
inUpdate = False
inIndex = False
formatRe = re.compile(r"format.html { redirect_to.*notice: '(.*)'")
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
            notic = "%s was successfully %s\n" % (mname, act)
            mo = re.search(formatRe, ln)
            if mo:
                notic = mo.group(1)
            newf.write("%sformat.html { redirect_to %s,\n" % (dent, url))
            newf.write("%s              notice: '%s' }\n" % (dent, notic))
            show = False
    if inIndex and ln.find('.all') != -1:
        toks = ln.strip().split()
        t2 = toks[2].split('.')
        if t2[1] == 'all':
            mname = t2[0]
    if show:
        newf.write(ln)

newf.close
oldf.close
