#!/bin/sh
pkgs="nrpe nagios-plugins-all"
partition=`df -kh | awk 'NR==2' | awk '{print $1}'`
echo "[+] Installting $pkgs"
#yum install $pkgs -y
echo "[+} Fetching common nrpe.cfg from MCM Env"
wget -q https://raw.github.com/at-/bash/master/nrpe.cfg -O /etc/nagios/nrpe.cfg
echo "[+] Modify partition & monitoring host"
sed -i 's|yourhost|103.26.101.2|g' /etc/nagios/nrpe.cfg
sed -i 's|yourpartition|'"$partition"'|g' /etc/nagios/nrpe.cfg
echo "[+] Set as startup"
chkconfig nrpe on
echo "[+] Starting services"
service nrpe start
echo "[+] Done"
