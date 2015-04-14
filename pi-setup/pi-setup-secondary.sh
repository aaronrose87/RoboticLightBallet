#!/bin/bash

# Sets up a Raspberry Pi for the Robotic Light Ballet project.
# This should be run on the Pi(s) that will connect to the primary.


# Pull down and source the common functions
wget --no-check-certificate -O pi-setup-common.sh https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup-common.sh

. ./pi-setup-common.sh

SUPPLICANT=/etc/wpa_supplicant/wpa_supplicant.conf
PRESERVE $SUPPLICANT
FRESH $SUPPLICANT
cat <<EOF >> $SUPPLICANT
network={
ssid="studiobot"
psk="lightballet"
proto=RSN
key_mgmt=WPA-PSK
pairwise=CCMP
auth_alg=OPEN
}
EOF

ifconfig

