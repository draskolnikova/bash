#!/bin/bash
# http://www.github.com/at-/bash
# at-03/2013
# ./lockfiles.sh <YOUR_REMOTE_IP>
if [ "$(ps auxw | grep $1 | grep -v grep)" != "" ];then
        echo "[!] Rsync is running ..."
        echo "[!] Exiting!"
        exit
fi
echo "[+] Receive incoming packets ..."
[YOUR RSYNC PARAMETER HERE]
echo "[+] Done"
