# docker-nginx

## nginx-1.6.1 build from source

This is a nginx container build from source. It's always a good idea to build nginx from source on your machine. You can use this Dockerfile to rebuild nginx easily on all of your machines.

## Directories
```sh
# bin
/usr/sbin/nginx

# conf
/etc/nginx/nginx.conf

# error-log
/var/log/nginx/error.log

# access-log
/var/log/nginx/access.log
```

### Don't forget to put 'daemon off;' on top of you nginx.conf

## Usage example
```sh
sudo docker run -d --name nginx -v /home/<username>/nginx.conf:/etc/nginx/nginx.conf -v /home/<username>/wwwsrc:/wwwsrc -p 80:80 jimbeaudoin/nginx service nginx start
```