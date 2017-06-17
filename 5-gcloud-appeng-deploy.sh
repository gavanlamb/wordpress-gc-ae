#!/bin/bash
DOMAIN_FOR_STAGING_BUCKET="staging.gavanlamb.com"

echo -e "\n";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m        DEPLOY AND BROWSE WORDPRESS        \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
cd wordpress-project &&
gcloud app deploy \
--promote \
--stop-previous-version \
--bucket=gs://$DOMAIN_FOR_STAGING_BUCKET app.yaml cron.yaml &&
gcloud app browse