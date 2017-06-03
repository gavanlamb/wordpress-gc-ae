#!/bin/bash
GCE_REGION="asia-northeast1"
GCE_ZONE="a"
GCE_TIER="db-n1-standard-1"
GCE_INSTANCE_ACTIVATION_POLICY="ALWAYS"
GCE_INSTANCE_BACKUP_TIME="02:00"
MYSQL_VERSION="MYSQL_5_7"
MYSQL_REPLICATION="SYNCHRONOUS"
MAINTENANCE_WINDOW_DAY="SUN"
MAINTENANCE_WINDOW_HOUR="02"
SQL_SERVER_INSTANCE_NAME="wp"
SQL_ROOT_PASSWORD="KL7wf1nggh"

echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m           Creating SQL instance           \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
gcloud sql instances create $SQL_SERVER_INSTANCE_NAME \
--tier=$GCE_TIER \
--database-version=$MYSQL_VERSION \
--region=$GCE_REGION \
--gce-zone=$GCE_REGION-$GCE_ZONE \
--activation-policy=$GCE_INSTANCE_ACTIVATION_POLICY \
--backup-start-time=$GCE_INSTANCE_BACKUP_TIME \
--replication=$MYSQL_REPLICATION \
--storage-auto-increase \
--maintenance-window-day=$MAINTENANCE_WINDOW_DAY \
--maintenance-window-hour=$MAINTENANCE_WINDOW_HOUR

gcloud sql users set-password root /
--instance=$SQL_SERVER_INSTANCE_NAME /
--password=$SQL_ROOT_PASSWORD