basic="bash-completion \
htop \
iotop \
sysstat \
nginx \
httpd-devel \
httpd
phpMyAdmin.noarch;
atombase="mariadb-server.x86_64 \
mariadb.x86_64 \
mariadb-libs.x86_64 \
mariadb-devel.x86_64 \
php.x86_64 \
php-devel.x86_64 \
php-common.x86_64 \
php-gd.x86_64 \
php-mbstring.x86_64 \
php-mcrypt.x86_64 \
php-mysql.x86_64 \
php-pecl-imagick.x86_64 \
php-php-gettext.x86_64 \
php-xmlrpc.x86_64 \
php-xml.x86_64 \
php-fpm.x86_64";
yum -y install $basic
yum -y install $atombase --enablerepo atomic
