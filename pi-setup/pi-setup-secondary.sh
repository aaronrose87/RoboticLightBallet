#!/bin/bash

# Sets up a Raspberry Pi for the Robotic Light Ballet project.
# This should be run on the Pi(s) that will connect to the primary.


# Pull down and source the common functions
wget --no-check-certificate -O pi-setup-common.sh https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup-common.sh

. ./pi-setup-common.sh

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
wpa_passphrase=lightballet
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
  range 10.10.0.2 10.10.0.10;
}
EOF

echo "Activate wlan0, hostapd, and isc-dhcp-server"
ifdown wlan0
ifup wlan0
/etc/init.d/hostapd restart
/etc/init.d/isc-dhcp-server restart

ifconfig

