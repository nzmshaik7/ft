#!/bin/bash

# Running under bundle leads to:
# Unable to load the EventMachine C extension;
# To use the pure-ruby reactor, require 'em/pure_ruby'
#
# Putting require 'em/pure_ruby'. didn't work

# Just run without bundle.

if [ ! -e ssl/ft.key ]; then
    echo "Run from /home/rails/ft directory"
    exit 1
fi

set -v 
thin start -p 3443 --ssl --ssl-key-file ssl/ft.key --ssl-cert-file ssl/futuretech_membershipauto_com.crt
