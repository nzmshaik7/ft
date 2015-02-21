#!/bin/bash

if [ `hostname` != calliope.donlaw.lab ]; then
    echo "Run on calliope"
    exit 3
fi

if [ -z "$1" ]; then
    echo "Usage: sendgit.sh ip_address"
    exit 1
fi
ip=$1

ssh -l git -o StrictHostKeyChecking=no $ip hostname
if [ $? -ne 0 ]; then
    echo "ERROR: Cannot ssh to $ip"
    exit 2
fi

cd /home/git
rsync -az -e ssh ft.git git@$ip:
