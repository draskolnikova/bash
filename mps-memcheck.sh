#!/bin/bash
# at-03/2013
# Memory checker and auto-resize /var/cache/mod_pagespeed
# Put on crontab to monitor every minutes memory growth
# * * * * * sh /path/to/mps-memcheck.sh

HOST=`hostname | awk -F"." '{print $1}'`
CRIT=`df -kh | grep cache | awk '{print $5}' | awk -F"%" '{print $1}'`
MNT=`mount | grep cache | awk '{print $6}' | awk -F"=" '{print $2}' | awk -F"m" '{print $1}'`
NEW=`bc << EOF
$MNT * 0.10
EOF
`
TOTAL=`bc << EOF
$MNT + $NEW
EOF
`

CETAK=`echo $NEW | awk '{printf "%.0f\n", $1}'`
CETAKTOT=`echo $TOTAL | awk '{printf "%.0f\n", $1}'`

if [ $CRIT -gt "97" ]; then
        rm -f /root/mps.log > /dev/null
        # For twitter updates, check your pkgs here 
        # https://github.com/tweepy/tweepy
        python tweet.py "STATUS [ ${HOST^^} ] - Pagespeed CRITICAL on `date`"
        echo "Cache dir critical on `date`" >> /root/mps.log
        echo "Auto-resize enabled, added "$CETAK" MBytes (10%) from "$MNT" MBytes to cache dir" >> /root/mps.log
        echo "Now cache dir resized to $CETAKTOT Mbytes" >> /root/mps.log
        echo "Don't panic, it's cool bro! Your website traffic is great!" >> /root/mps.log
        mount -t tmpfs -o remount,size="$CETAKTOT"m,uid=48,gid=48,mode=0755 tmpfs /var/cache/mod_pagespeed
        python tweet.py "STATUS [ ${HOST^^} ] - Pagespeed RESOLVED on `date`"
else
      exit
fi
