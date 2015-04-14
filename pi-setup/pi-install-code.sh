#!/bin/bash

# This assumes the pi-setup-primary.sh or pi-setup-secondary.sh
# scripts have already been run.

. ./pi-setup-functions.sh

cd ~pi
git clone https://github.com/mitmuseumstudio/RoboticLightBallet.git

RCLOCAL=/etc/rc.local
PRESERVE $RCLOCAL
FRESH $RCLOCAL

RUNNER=/home/pi/RoboticLightBallet/pi-setup/pi-run-code.sh

sed "/exit 0/i \ $RUNNER &" \
    < $RCLOCAL > /home/pi/rc.local.new 

mv /home/pi/rc.local.new $RCLOCAL
chmod o+x $RCLOCAL





