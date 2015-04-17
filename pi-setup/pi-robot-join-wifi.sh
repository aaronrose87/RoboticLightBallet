#!/bin/bash

# Check IP address to see if this Pi is connected to the wifi network.
# If not, loop while trying to connect until it is.
#

_IP=$(hostname -I) || true

SSID=$(sed -n -e '/ssid/s/"//g' -e '/ssid/s/ssid=//' \
           < /etc/wpa_supplicant/wpa_supplicant.conf)


echo -n "Connecting to $SSID wifi network"

while [[ ! ("$_IP" == *10.10.*) ]]; do
    echo -n "."
    ifdown wlan0 2>&1 | logger
    sleep 2
    ifup wlan0 2>&1 | logger
    sleep 2
    _IP=$(hostname -I) || true
done
echo ". IP address: $_IP"
