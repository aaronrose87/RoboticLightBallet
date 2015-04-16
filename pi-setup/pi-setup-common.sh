#!/bin/bash

wget --no-check-certificate -O pi-setup-functions.sh https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup-functions.sh

. ./pi-setup-functions.sh

# Bring the OS up to date
echo "Updating packages"
apt-get -y update
echo "Upgrading packages"
apt-get -y upgrade

# install needed packages
echo "Installing packages"
apt-get -y install apache2 emacs python-pip


