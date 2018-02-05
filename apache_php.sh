#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#Update packages and Upgrade system
echo "Updating System"
sudo apt-get -y update && sudo apt-get -y upgrade

echo "Installing Apache2"
sudo apt-get -y --allow-unauthenticated install apache2

#Finding Public IP of Server
#PUB_IP="$(ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//')"
PUB_IP="$(ifconfig eth0 | grep 'inet addr' | awk '{ print $2 }')"

#Editing apache2.conf file
#echo "ServerName $PUB_IP" >> /etc/apache2/apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Installing PHP and required modules
echo "Installing php modules"
echo "deb http://ftp.de.debian.org/debian stretch main" >> /etc/apt/sources.list
apt-get -y --allow-unauthenticated install php7.0-fpm php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0-mcrypt php7.0-mysql php-mysqlnd

#Setting permissions and ownership for /var/www
echo "Setting ownership on /var/www"
sudo chown -R www-data:www-data /var/www

#Downloading demo.php file
wget https://raw.githubusercontent.com/martinbjorgan/test/master/demo.php -O /var/www/html/demo.php
sudo chown -R www-data:www-data /var/www/html/demo.php

# Enable PHP and restart apache
sudo phpenmod mysqli
sudo apache2ctl restart
