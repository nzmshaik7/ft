#!/bin/bash

if [ -z "$pw" ]; then
    echo "Set pw first"
    exit 1
fi

opts="-u dlaw -p$pw ft_development"
mysqldump $opts
