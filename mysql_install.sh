#!/bin/bash
apt-get update -y
apt-get install -y expect
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -q -y install mysql-server

# Not required in actual script
MYSQL_ROOT_PASSWORD=root

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Would you like to setup VALIDATE PASSWORD plugin?\"
send \"n\r\"
expect \"Change the password for root ?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")


echo "$SECURE_MYSQL"

#Overwrite mysql config and restart mysql service
wget http://grendelaget.com/terraform_azure/mysqld.cnf -O /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

mysql -u root -proot -e "CREATE DATABASE test;"
mysql -u root -proot -e "use test; create table data (name varchar(100) primary key);"
mysql -u root -proot -e "grant all on *.* to root@'%' identified by 'root';"
apt-get purge -y expect
