#!/bin/bash

exit 1

set -v

rails generate scaffold User \
        role:integer first_name:string last_name:string

rails generate controller Static home --no-assets --no-helper
rails generate controller Mockup internal_veh multi_veh customer_veh store \
                                      --no-assets --no-helper
rails generate controller Top db --no-assets --no-helper
