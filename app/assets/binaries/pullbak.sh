#!/bin/bash

if /usr/local/bin/networkDown; then
    exit 0
fi

BAKDIR=/home/dlaw/salient/membershipauto/server/aws/devdbbak
exec 1>>$BAKDIR/log.txt 2>&1

cd $BAKDIR

downame="dump-`date +'%a%H'`.gz"
weeklyname="dump-`date +'%y%m%d'`.gz"
if [ `date +'%a'` == Fri -a ! -e weekly/$weeklyname ]; then
    mv $downame weekly/$weeklyname
fi
scp devdump.sh rails@membershipauto.com:bin
ssh membershipauto.com -l rails bin/devdump.sh > $downame
ssh membershipauto.com -l rails rm bin/devdump.sh
