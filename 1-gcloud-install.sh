#!/bin/bash
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m               GCLOUD INSTALL              \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" ;
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &&
sudo apt-get update && 
sudo apt-get install -y google-cloud-sdk &&

echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
echo -e "\e[42m\e[39m          PLEASE INITIALIZE GCLOUD         \e[0m\e[0m";
echo -e "\e[42m\e[39m                                           \e[0m\e[0m";
gcloud init &&

sudo chown -R $SUDO_USER /home/$SUDO_USER/.config
sudo chown -R $SUDO_USER /home/$SUDO_USER/.gsutil