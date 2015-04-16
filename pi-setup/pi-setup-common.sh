#!/bin/bash

. ./pi-setup-functions.sh

# Bring the OS up to date
echo "Updating packages"
apt-get -y update
echo "Upgrading packages"
apt-get -y upgrade

# install needed packages
echo "Installing packages"
apt-get -y install apache2 emacs python-pip


