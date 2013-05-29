#!/bin/bash
# Basic Server Initialization
# ~ting - 28/05/2013
yum -y update
init="wget nano yum-presto yum-plugin-security yum-plugin-protectbase dmidecode setroubleshoot-server"
#initchk=`for i in $init; do rpm -qa | grep $i; done`
yum -y install $init
epelchk=`rpm -qa | grep epel | wc -l`
atomicchk=`rpm -qa | grep atomic | wc -l`
echo "[+] Adding Nginx repository .."
if [ ! -f /etc/yum.repos.d/nginx.repo ]; then
	wget -q -nv https://raw.github.com/at-/bash/master/nginx.repo -O /etc/yum.repos.d/nginx.repo
fi
echo "[+] Nginx repository already exists!"
echo "[+] Adding EPEL repository .."
if [ $epelchk != 1 ];then
	yum -y localinstall http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
fi
echo "[+] EPEL repository already exists!"
echo "[+] Adding Atomic repository .."
if [ $atomicchk != 1 ];then
	wget -q -O - http://www.atomicorp.com/installers/atomic | sh
fi
echo "[+] Atomic repository already exists!"
echo "[+] Disabling atomic repository, use --enablerepo instead"
sed -i 's/enabled = 1/enabled = 0/g' /etc/yum.repos.d/atomic.repo
echo "[+] Cleaning & caching new repository .."
yum clean all > /dev/null
yum makecache --enablerepo atomic > /dev/null
echo "[+] Installing initialization software .."
sh basic-server-software.sh
echo "[+] Done! :-)"
