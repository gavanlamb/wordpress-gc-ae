#!/bin/bash
DOMAIN_FOR_BUCKET=""
DOMAIN_FOR_STAGING_BUCKET=""
GCE_REGION="asia-northeast1"
GCE_ZONE="a"
PATH_TO_YOUR_SERVICE_ACCOUNT_JSON=""
PROJECT_ID="project-1"
SQL_DB_NAME="wp"
SQL_DB_USER="wp"
SQL_DB_PASSWORD="#569y8A4"
SQL_ROOT_PASSWORD="KL7wf1nggh"
SQL_SERVER_INSTANCE_NAME="wp"
WORDPRESS_URL=""

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m                CREATE BUCKET              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
gsutil mb -c regional -l $GCE_REGION gs://$DOMAIN_FOR_BUCKET/ &&
gsutil mb -c regional -l $GCE_REGION gs://$DOMAIN_FOR_STAGING_BUCKET/ &&
gsutil defacl ch -u AllUsers:R gs://$DOMAIN_FOR_BUCKET &&

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m          CLOUD SQL PROXY SETUP &          \e[0m\e[0m";
echo -e "\e[42m\e[39m       OPENNING MYSQL TO CREATE A DB       \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cloud_sql_proxy \
-dir /tmp/cloudsql \
-instances=$PROJECT_ID:$GCE_REGION:$SQL_SERVER_INSTANCE_NAME=tcp:3306 \
-credential_file=$PATH_TO_YOUR_SERVICE_ACCOUNT_JSON & 
mysql -h 127.0.0.1 \
--user="root" \
--password="$SQL_ROOT_PASSWORD" \
--execute="create database $SQL_DB_NAME; create user $SQL_DB_USER@% identified by $SQL_DB_PASSWORD; grant all on $SQL_DB_NAME.* to $SQL_DB_USER@%; exit" &&

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m     INSTALLING COMPONENTS WITH COMPOSER   \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cd wordpress &&
composer install &&
composer require php $PHP_VERSION &&

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m              SETUP WORDPRESS              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
php wordpress/wordpress-helper.php setup -n \
--env=FLEXIBLE_ENV \
--dir ./wordpress-project \
--project_id $PROJECT_ID \
--db_instance=$SQL_SERVER_INSTANCE_NAME \
--db_name=$SQL_DB_NAME \
--db_user=$SQL_DB_USER \
--db_password=$SQL_DB_PASSWORD \
--wordpress_url=$WORDPRESS_URL \
--db_password=$SQL_DB_PASSWORD &&

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m        DEPLOY AND BROWSE WORDPRESS        \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cd wordpress-project &&
gcloud app deploy --promote --stop-previous-version app.yaml cron.yaml &&
gcloud app browse