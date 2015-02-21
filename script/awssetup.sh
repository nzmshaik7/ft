#!/bin/bash

# this runs on the clean AWS server before running cap.

yum install -y nodejs epel-release httpd
sudo dd if=/dev/zero of=/swap bs=1M count=2048
mkswap /swap
chmod 600 /swap
swapon /swap

cat > /var/www/html/index.html << 'EOFI'
<html>
<body>
<H3>Don web box</H3>
</body>
</html>
EOFI

service httpd start
yum install -y ruby-devel gcc zlib-devel patch git
gem install bundler rails
gem install passenger
yum install -y gcc-c++ mysql51-server mysql51 mysql51-devel
chkconfig --level 345 mysqld on
service mysqld start
echo "=== Edit httpd.conf "
mysql_secure_installation

mysql --user=root -pav1jk2 <<EOFD
create database ft_production;

GRANT ALL PRIVILEGES ON ft_production.* to deployer@localhost
IDENTIFIED BY 'tkfu0794' WITH GRANT OPTION;

EOFD

yum install -y libcurl-devel openssl-devel httpd-devel apr-devel apr-util-devel
passenger-install-apache2-module
gem install capistrano

useradd -m deployer
cd deployer/
mkdir .ssh
chmod 700 .ssh
chown deployer:deployer .ssh
cd .ssh
cat > authorized_keys <<EOFK
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA7dO0ACSwe+rSZ75lucpgIgZl2fv+QAYdXWuVUZpU44pfUaPaq0Qnvh4sSaq6IkXO6B51eXSz/ZoI26RNn0KIlWyZbxfcLQvF/CEFCREplBaM1sq5BerMDFq5q30HREqTFrltk6/XECQxdXP91BMotmdcddpnpT7JeTLwUgTsnxl0IwXItHcVmJg13SILg2qpR6922Qn7GXVvtKGL7s09kZmFYno5THTS7WOhcgPh4V1Ar3azxH58CLlxAn0seqmk7E4n0xBLEApRbW4NXF6PlagpLmtwY7NmNNh2XZQDaksIe9xTH8i8gvv+F51whofy4LK+/u/jr1oIwMWpeSL2hQ== dlaw@cen6631.donlaw.lab
EOFK

chown deployer:deployer authorized_keys
chmod 600 authorized_keys 

gem install mysql2
yum install --enablerepo=epel -y nodejs
