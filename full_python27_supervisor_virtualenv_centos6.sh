#!/bin/bash

sudo yum groupinstall -y development
sudo yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel   wget xz-libs
sudo wget http://www.python.org/ftp/python/2.7.16/Python-2.7.16.tar.xz
sudo xz -d Python-2.7.16.tar.xz
sudo tar -xvf Python-2.7.16.tar
cd Python-2.7.16
sudo ./configure --prefix=/usr/local
sudo make && make altinstall

/usr/local/bin/pip install virtualenv

/usr/local/bin/pip install supervisor
ln -s /usr/local/bin/supervisord /bin/supervisord
ln -s /usr/local/bin/supervisorctl /bin/supervisorctl

mkdir -p /etc/supervisord/conf.d
/usr/local/bin/echo_supervisord_conf > /etc/supervisord.conf
echo "[include]" >> /etc/supervisord.conf
echo "files = conf.d/*.ini" >> /etc/supervisord.conf

wget https://raw.githubusercontent.com/quanghuy1288/script/master/extra/supervisord -O /etc/init.d/supervisord
chmod +x /etc/init.d/supervisord
chkconfig --add supervisord
chkconfig supervisord on
service supervisord status
