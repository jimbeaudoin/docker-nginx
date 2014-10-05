#!/bin/bash

# Nginx 1.6.1 Installation on Debian 7.6

# (c) Jimmy Beaudoin, 2014

echo ""
echo "Updating the system..."
echo ""

sudo apt-get update
sudo apt-get -y upgrade

echo ""
echo "Installing prerequisites..."
echo ""

sudo apt-get -y install curl gcc make g++ openssl libssl-dev libpcre3-dev

echo ""
echo "Zlib installation..."
echo ""

curl -O http://zlib.net/zlib-1.2.8.tar.gz
tar -xzf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
sudo make
sudo make install
cd ..
rm -rf zlib-1.2.8 zlib-1.2.8.tar.gz

echo ""
echo "Nginx installation..."
echo ""

curl -O http://nginx.org/download/nginx-1.6.1.tar.gz
tar -xzf nginx-1.6.1.tar.gz
cd nginx-1.6.1
./configure --user=www-data --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-file-aio --with-http_realip_module --with-http_spdy_module --without-http_scgi_module --without-http_uwsgi_module --without-http_fastcgi_module
sudo make
sudo make install
cd ..
rm -rf nginx-1.6.1 nginx-1.6.1.tar.gz

echo ""
echo "Copying Nginx script..."
echo ""

cat $PWD/nginx.script | sudo tee -a /etc/init.d/nginx >/dev/null

sudo chmod +x /etc/init.d/nginx

echo ""
echo "Cleaning up..."
echo ""

sudo apt-get -y remove curl gcc make g++
sudo apt-get -y autoremove

echo ""
echo "Done!"
echo "You can try 'service nginx start' or 'service nginx status' now."
echo ""
