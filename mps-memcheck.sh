#!/bin/bash
# at-03/2013
# Memory checker and auto-resize /var/cache/mod_pagespeed
# Put on crontab to monitor every minutes memory growth
# * * * * * sh /path/to/mps-memcheck.sh

CRIT=`df -kh | grep cache | awk '{print $5}' | awk -F"%" '{print $1}'`
TOT=`df -kh | grep cache | awk '{print $2}' | awk -F"." '{print $1}'`
MNT=`mount | grep cache | awk '{print $6}' | awk -F"=" '{print $2}' | awk -F"m" '{print $1}'`
NEW=`bc << EOF
$TOT * (0.10*1024)
EOF
`
TOTAL=`bc << EOF
$MNT + $NEW
EOF
`

if [ $CRIT -gt "97" ]; then
        echo "Cache dir critical :("
        echo -n "Auto-resize enabled, added "
        printf "%.0f" $(echo "scale=2;$NEW" | bc); echo "MB (10%) from "$MNT"MB to cache dir"
        echo -n "Now cache dir resized to "
        printf "%.0f" $(echo "scale=2;$TOTAL" | bc); echo ""
        CETAK=`echo $NEW | awk '{printf "%.0f\n", $1}'`
        mount -t tmpfs -o remount,size="$CETAK"m,uid=48,gid=48,mode=0755 tmpfs /var/cache/mod_pagespeed
else
      echo "Cache dir normal :)"
fi
