#!/bin/bash

# After adding a table:
# 2to4 on model and controller (1 file at a time)
# add to top/db.html.erb
# Make index look like table
# Put permission restrictions on controllers
# In create and update, change
# format.html { redirect_to @region, notice ...
# to
# format.html { redirect_to regions_url, notice ...
# Add prepFormVariables for *_id if needed.

# DATABASE SCHEMA

function RAILS() {
    echo " "
    echo rails $*
    echo " "
    echo -n "enter: "
    read ans
    rails $* --no-assets --no-helper
}


gen=( generate scaffold ServiceVisitNotes
    service_visit_id:integer
    user_id:integer
    note:text
    )
RAILS ${gen[*]}


gen=( generate scaffold Backup
    table_name:string
    user_id:integer
    info:text
    )
RAILS ${gen[*]}
