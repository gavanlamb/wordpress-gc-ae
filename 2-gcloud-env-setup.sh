#!/bin/bash
MYSQL_ROOT_PASSWORD_LOCAL="W0rdpass" 
BIN_FOLDER_PATH="/usr/local/bin"
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m               INSTALLING PHP              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
add-apt-repository ppa:ondrej/php -y ;
apt-get update -y ;
apt-get remove -y php7.0 ;
apt-get install -y php7.1 &&
apt-get install -y php &&
apt-get install -y php7.1-zip &&
apt-get install -y php-xml ;

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m            INSTALLING COMPOSER            \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
apt-get install -y composer ;

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m             INSTALLING MYSQL              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
apt-get update ;
echo "mysql-server mysql-server/root_password password W0rdpass" | debconf-set-selections &&
echo "mysql-server mysql-server/root_password_again password W0rdpass" | debconf-set-selections &&
apt -y install mysql-server &&
usermod -d /var/lib/mysql/ mysql ;

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m          GETTING CLOUD SQL PROXY          \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
wget "https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64" -O $BIN_FOLDER_PATH/cloud_sql_proxy &&
chmod +x $BIN_FOLDER_PATH/cloud_sql_proxy