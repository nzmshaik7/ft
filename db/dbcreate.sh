#!/bin/bash

mysql --user=root -p <<EOF
create database ft_development;

GRANT ALL PRIVILEGES ON ft_development.* to dlaw@localhost
    IDENTIFIED BY 'tkfu0794' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON ft_development.* to dlaw@cen6631
    IDENTIFIED BY 'tkfu0794' WITH GRANT OPTION;

EOF
