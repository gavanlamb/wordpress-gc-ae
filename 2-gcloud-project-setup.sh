#!/bin/bash
GCE_REGION="asia-northeast1"
GCE_ZONE="a"
GCE_TIER="db-f1-micro"
GCE_INSTANCE_ACTIVATION_POLICY="ALWAYS"
GCE_INSTANCE_BACKUP_TIME="02:00"
MYSQL_VERSION="MYSQL_5_7"
MYSQL_MASTER_INSTANCE_NAME="wp"
MYSQL_REPLICATION="SYNCHRONOUS"
SQL_SERVER_INSTANCE_NAME="wp"
SQL_ROOT_PASSWORD="KL7wf1nggh"

echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m           Creating SQL instance           \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
gcloud sql instances create $SQL_SERVER_INSTANCE_NAME \
--activation-policy=$GCE_INSTANCE_ACTIVATION_POLICY \
--backup \
--backup-start-time=$GCE_INSTANCE_BACKUP_TIME \
--database-version=$MYSQL_VERSION \
--gce-zone=$GCE_REGION-$GCE_ZONE \
--master-instance-name=$MYSQL_MASTER_INSTANCE_NAME \
--region=$GCE_REGION \
--tier=$GCE_TIER \
--replication=$MYSQL_REPLICATION

gcloud sql instances set-root-password $SQL_SERVER_INSTANCE_NAME \
--password=$SQL_ROOT_PASSWORD
