#!/bin/bash

set -v

rails generate scaffold User \
        role:integer first_name:string last_name:string
