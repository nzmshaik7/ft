#!/bin/bash

prodsw=$1
file=$2
if [ X"$prodsw" != X-d -a X"$prodsw" != X-p ]; then
    echo "Usage: run.sh [-d|-p] rubyfile"
    exit 1
fi
if [ ! -e "$file" ]; then
    echo "no file $file"
    echo "Usage: run.sh [-d|-p] rubyfile"
    exit 1
fi


opts=
if [ X"$prodsw" == X-p ]; then
    opts="-e production"
fi

set -x
rails runner $opts $PWD/$file
