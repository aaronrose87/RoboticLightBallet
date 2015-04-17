#!/bin/bash

# Check IP address to see if this Pi is connected to the wifi network.
# If not, loop while trying to connect until it is.
#

# If called with a number, quietly loop forever, sleeping for
# that many seconds between loops.

LOOP=${1:-""}
if [[ $LOOP ]]; then VERBOSE=""; else VERBOSE=true; fi

_IP=$(hostname -I) || true

SSID=$(sed -n -e '/ssid/s/"//g' -e '/ssid/s/ssid=//' \
           < /etc/wpa_supplicant/wpa_supplicant.conf)


ECHOP() {
    if [[ $VERBOSE ]]; then echo $*; fi
}

WIFI_JOIN() {
    ECHOP -n "Connecting to $SSID wifi network"

    while [[ ! ("$_IP" == *10.10.*) ]]; do
        ECHOP -n "."
        ifdown wlan0 2>&1 | logger
        sleep 2
        ifup wlan0 2>&1 | logger
        sleep 2
        _IP=$(hostname -I) || true
    done
    ECHOP ". IP address: $_IP"
}

WIFI_JOIN

while [[ $LOOP ]] ; do
    sleep $LOOP
    WIFI_JOIN
done

