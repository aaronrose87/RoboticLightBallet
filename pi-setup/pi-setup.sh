!#/bin/bash

# If there's not already a preserved file ending in .orig
# make one by renaming.
function PRESERVE() {
    if [[ ! -f ${1}.orig ]] ; then
        mv ${1} ${1}.orig
    fi
}

# If there's a preserved file, make a fresh copy of it
# in its original place
function FRESH() {
    if [[ -f ${1}.orig ]] ; then
        cp ${1}.orig ${1}
    fi
}

# Bring the OS up to date
apt-get update
apt-get upgrade

# install needed packages
apt-get install iw isc-dhcp-server hostapd apache2
apt-get install emacs

# get a custom hostapd that can deal with the Belkin WiFi
wget http://www.adafruit.com/downloads/adafruit_hostapd.zip
unzip adafruit_hostapd.zip

PRESERVE /usr/sgin/hostapd

mv hostapd /usr/sbin
chmod 755 /usr/sbin/hostapd

# Set up the config files
PRESERVE /etc/network/interfaces
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet static
address 10.10.0.1
netmask 255.255.0.0
EOF

PRESERVE /etc/hostapd/hostapd.conf
cat <<EOF > /etc/hostapd/hostapd.conf
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

PRESERVE /etc/default/hostapd
FRESH /etc/default/hostapd
cat <<EOF >> /etc/default/hostapd
DAEMON_CONF= "/etc/hostapd/hostapd.conf"
EOF

PRESERVE /etc/dhcp/dhcpd.conf
FRESH /etc/dhcp/dhcpd.conf
cat <<EOF >> /etc/dhcp/dhcpd.conf
subnet 10.10.0.0 netmask 255.255.0.0 {
  range 10.10.0.2 10.10.0.10
}
EOF

