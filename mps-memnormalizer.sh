#!/bin/bash
# at-03/2013
# Memory normalizer and auto-resize /var/cache/mod_pagespeed
# Put your memory back to 2048Mbytes every 00:00
# 0 0 * * * sh /path/to/mps-normalizer.sh

MNT=`mount | grep cache | awk '{print $6}' | awk -F"=" '{print $2}' | awk -F"m" '{print $1}'`
HOST=`hostname | awk -F"." '{print $1}'`
if [ $MNT -eq "2048" ]; then
        exit
else
        mount -t tmpfs -o remount,size=2048m,uid=48,gid=48,mode=0755 tmpfs /var/cache/mod_pagespeed
        python tweet.py "STATUS [ ${HOST^^} ] - Pagespeed Memory set 2048M on `date`"
fi
