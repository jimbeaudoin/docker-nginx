# Copyright 2014 Jimmy Beaudoin

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM debian

MAINTAINER Jimmy Beaudoin <contact@jim-beaudoin.com>

# Update the system
RUN apt-get update
RUN apt-get -y upgrade

# Install compilers
RUN apt-get install -y curl gcc make g++ openssl libssl-dev libpcre3-dev

# zlib installation
RUN curl -O http://zlib.net/zlib-1.2.8.tar.gz
RUN tar -xzf zlib-1.2.8.tar.gz
RUN zlib-1.2.8/configure
RUN zlib-1.2.8/make
RUN zlib-1.2.8/make install
RUN rm -rf zlib-1.2.8

# nginx installation
RUN curl -O http://nginx.org/download/nginx-1.6.1.tar.gz
RUN tar -xzf nginx-1.6.1.tar.gz

RUN nginx-1.6.1/configure --user=nginx --group=nginx --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-file-aio --with-http_realip_module --without-http_scgi_module --without-http_uwsgi_module --without-http_fastcgi_module

RUN nginx-1.6.1/make && make install

ADD ./nginx /etc/init.d/nginx

RUN chmod +x /etc/init.d/nginx