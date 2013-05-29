for i in 
bash-completion \
htop \
iotop \
sysstat \ 
nginx \
mariadb-server.x86_64 \
mariadb.x86_64 \
mariadb-libs.x86_64 \
mariadb-devel.x86_64 \
phpMyAdmin.noarch \
mysql-devel.x86_64;
yum -y install $i;
done;
