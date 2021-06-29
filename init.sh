#!/bin/sh


# Mysql configuration

sudo /etc/init.d/mysql start

mysql -u root -e "CREATE DATABASE stepic_web_db;"
mysql -u root -e "CREATE USER me IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'me'@'localhost';"


# WSGI configuration

mkdir -p log
gunicorn -b 0.0.0.0:8080 hello:wsgi_application >> log/gunicorn_hello.log 2>&1 &

cd ask
./manage.py makemigrations
./manage.py migrate
gunicorn -b 0.0.0.0:8000 ask.wsgi >> ../log/gunicorn_stackoverflow.log 2>&1 &
cd ..


# Nginx configuration

NGINX_CONF_LINK_DEFAULT=/etc/nginx/sites-enabled/default

NGINX_CONF_LINK_NEW=/etc/nginx/sites-enabled/nginx.conf
NGINX_CONF_FILE_NEW=/home/box/web/etc/nginx.conf

if test -L $NGINX_CONF_LINK_DEFAULT; then
	sudo unlink $NGINX_CONF_LINK_DEFAULT
fi

sudo ln -s $NGINX_CONF_FILE_NEW $NGINX_CONF_LINK_NEW
sudo /etc/init.d/nginx restart
