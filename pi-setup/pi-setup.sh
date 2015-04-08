#!/bin/bash

# If there's not already a preserved file ending in .orig
# make one by renaming.
PRESERVE() {
    if [[ ! -f ${1}.orig ]] ; then
        echo "Preserving ${1} to ${1}.orig"
        mv ${1} ${1}.orig
    else
        echo "Already preserved: ${1}.orig"
    fi
}

# If there's a preserved file, make a fresh copy of it
# in its original place
FRESH() {
    if [[ -f ${1}.orig ]] ; then
        echo "Making fresh copy of ${1}.orig to ${1}"
        cp ${1}.orig ${1}
    fi
}

# Bring the OS up to date
echo "Updating packages"
apt-get -y update
echo "Upgrading packages"
apt-get -y upgrade

# install needed packages
echo "Installing packages"
apt-get -y install iw isc-dhcp-server hostapd apache2
apt-get -y install emacs

# get a custom hostapd that can deal with the Belkin WiFi
echo "Getting Adafruit hostapd"
wget http://www.adafruit.com/downloads/adafruit_hostapd.zip
unzip adafruit_hostapd.zip

HOSTAPD=/usr/sbin/hostapd
PRESERVE $HOSTAPD
mv hostapd $HOSTAPD
chmod 755 $HOSTAPD

# Set up the config files
INTERFACES=/etc/network/interfaces
echo "Setting up $INTERFACES"
PRESERVE $INTERFACES
cat <<EOF > $INTERFACES
auto lo
iface lo inet loopback
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet static
address 10.10.0.1
netmask 255.255.0.0
EOF

HOSTAPDCONF=/etc/hostapd/hostapd.conf
echo "Setting up $HOSTAPDCONF"
PRESERVE $HOSTAPDCONF
cat <<EOF > $HOSTAPDCONF
interface=wlan0
driver=rtl871xdrv
ssid=studiobot
hw_mode=g
channel=1
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=ottopiene
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF

HOSTAPDDEFAULT=/etc/default/hostapd
echo "Setting up $HOSTAPDDEFAULT"
PRESERVE $HOSTAPDDEFAULT
FRESH $HOSTAPDDEFAULT
cat <<EOF >> $HOSTAPDDEFAULT
DAEMON_CONF="$HOSTAPDCONF"
EOF

DHCPCONF=/etc/dhcp/dhcpd.conf
echo "Setting up $DHCPCONF"
PRESERVE $DHCPCONF
FRESH $DHCPCONF
cat <<EOF >> $DHCPCONF
subnet 10.10.0.0 netmask 255.255.0.0 {
  range 10.10.0.2 10.10.0.10
}
EOF

