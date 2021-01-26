#!/bin/sh

NGINX_CONF_LINK_DEFAULT=/etc/nginx/sites-enabled/default

NGINX_CONF_LINK_NEW=/etc/nginx/sites-enabled/nginx.conf
NGINX_CONF_FILE_NEW=/home/box/web/etc/nginx.conf

# WSGI configuration

mkdir -p log
gunicorn -b 0.0.0.0:8080 etc.hello:wsgi_application >> log/gunicorn.log 2>&1 &

# Nginx configuration

if test -L $NGINX_CONF_LINK_DEFAULT; then
	sudo unlink $NGINX_CONF_LINK_DEFAULT
fi

sudo ln -s $NGINX_CONF_FILE_NEW $NGINX_CONF_LINK_NEW
sudo /etc/init.d/nginx restart
