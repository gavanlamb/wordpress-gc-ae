#!/bin/bash
#create a service account for the project, create a json key for this user
PROJECT_ID="project-1"
GCE_REGION="asia-northeast1"
GCE_ZONE="a"
SQL_SERVER_INSTANCE_NAME="appengine-wp"
PATH_TO_YOUR_SERVICE_ACCOUNT_JSON=""
SQL_ROOT_PASSWORD="KL7wf1nggh"
SQL_DB_NAME="wp"
SQL_DB_USER="wp"
SQL_DB_PASSWORD="#569y8A4"

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m                CREATE BUCKET              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
gsutil mb gs://$PROJECT_ID.appspot.com/ 
gsutil mb gs://staging.$PROJECT_ID.appspot.com/ 
gsutil defacl ch -u AllUsers:R gs://$PROJECT_ID.appspot.com

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m          CLOUD SQL PROXY SETUP &          \e[0m\e[0m";
echo -e "\e[42m\e[39m       OPENNING MYSQL TO CREATE A DB       \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
./cloud_sql_proxy \
-dir /tmp/cloudsql \
-instances=$PROJECT_ID:$GCE_REGION-$GCE_ZONE:$SQL_SERVER_INSTANCE_NAME=tcp:3306 \
-credential_file=$PATH_TO_YOUR_SERVICE_ACCOUNT_JSON & 
mysql -h 127.0.0.1 \
--user="root" \
--password="$SQL_ROOT_PASSWORD" \
--execute="create database $SQL_DB_NAME; create user $SQL_DB_USER@% identified by $SQL_DB_PASSWORD; grant all on $SQL_DB_NAME.* to $SQL_DB_USER@%; exit"

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m     INSTALLING COMPONENTS WITH COMPOSER   \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cd wordpress
composer install
composer require php $PHP_VERSION

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m              SETUP WORDPRESS              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
php wordpress-helper.php setup -n \
-d ./wordpress-project \
--db_instance=$SQL_SERVER_INSTANCE_NAME \
--db_name=$SQL_DB_NAME \
--db_user=$SQL_DB_USER \
-p $PROJECT_ID \
--db_password=$SQL_DB_PASSWORD

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m        DEPLOY AND BROWSE WORDPRESS        \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cd wordpress-project
gcloud app deploy --promote --stop-previous-version app.yaml cron.yaml
gcloud app browse