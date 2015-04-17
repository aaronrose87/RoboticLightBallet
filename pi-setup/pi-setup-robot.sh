#!/bin/bash

# Sets up a Raspberry Pi for the Robotic Light Ballet project.
# This should be run on the Pi(s) that will be in the robots.


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

# Pull down the wifi joining script and run it.
wget --no-check-certificate -O pi-robot-join-wifi.sh https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-robot-join-wifi.sh

chmod +x ./pi-robot-join-wifi.sh

# This will run until the Pi sees and has joined the network.
./pi-robot-join-wifi.sh

