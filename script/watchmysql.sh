#!/bin/bash

# Keep an eye on mysqld and restart it if it stops.
# This script is run nightly be cron.  If a copy is already running, it
# just exits.

MYSQLPID=/var/run/mysqld/mysqld.pid
WATCHPID=/var/run/watchmysql.pid
SELF=/root/bin/watchmysql.sh
MAX_DAILY_RESTARTS=10

if [ X$1 != X-b -a -e $WATCHPID ]; then
    wpid=`cat $WATCHPID`
    # not foolproof, but close enough
    kill -s 0 $wpid > /dev/null 2>&1
    if [ $? == 0 ]; then
        exit 0
    fi
fi

if [ X$1 != X-b ]; then
    # This is the cron job, kick off a background daemon
    nohup $SELF -b >> /root/var/watchmysql.out 2>&1 < /dev/null &
    exit 0
fi

echo $$ > $WATCHPID

DAY=0
RESTARTS=0
while true; do
    mpid=`cat $MYSQLPID`
    kill -s 0 $mpid > /dev/null 2>&1
    if [ $? != 0 ]; then
        echo "myslq pid $mpid is gone missing at `date`, ps says:"
        ps -ewf | grep mysql
        /sbin/service mysqld status | grep -q running
        if [ $? == 0 ]; then
            echo "service reports it as running, no action:"
            /sbin/service mysqld status
        else
            if [ $RESTARTS -gt $MAX_DAILY_RESTARTS ]; then
                echo "Too many restarts today, idling."
            else
                echo "Going to stop and restart ..."
                /sbin/service mysqld stop
                sleep 5
                /sbin/service mysqld start
                RESTARTS=$(($RESTARTS + 1))
                msg="mysqld died, restarting it at `date`"
                echo $msg | mail -s "MA mysql problem" cel1@donlaw.com
            fi
        fi
    fi
    if [ $RESTARTS != 0 ]; then
        if [ `date +%d` != $DAY ]; then
            RESTARTS=0
            DAY=`date +%d`
        fi
    fi
    sleep 600
done
