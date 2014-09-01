#!/bin/bash

# Nginx 1.6.1 Installation on Debian 7.6

# (c) Jimmy Beaudoin, 2014

echo "Updating the system..."
echo ""

apt-get update
apt-get -y upgrade

echo "Installing prerequisites..."
echo ""

apt-get -y install curl gcc make g++ openssl libssl-dev libpcre3-dev

echo "Zlib installation..."
echo ""

curl -0 http://zlib.net/zlib-1.2.8.tar.gz
tar -xzf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make && make install
cd ..
rm -rf zlib-1.2.8 zlib-1.2.8.tar.gz

echo "Nginx installation..."
echo ""

curl -O http://nginx.org/download/nginx-1.6.1.tar.gz
tar -xzf nginx-1.6.1.tar.gz
cd nginx-1.6.1
./configure --user=www-data --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-file-aio --with-http_realip_module --without-http_scgi_module --without-http_uwsgi_module --without-http_fastcgi_module
make && make install
cd ..
rm -rf nginx-1.6.1 nginx-1.6.1.tar.gz
cat ./nginx > /etc/init.d/nginx

echo "Cleaning up..."
echo ""

apt-get -y remove curl gcc make g++
apt-get -y autoremove

echo "Done!"
echo "You can try 'service nginx start' or 'service nginx status' now."
