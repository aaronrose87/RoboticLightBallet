# How to set up the Raspberry Pi

**Pi:** Rasberry Pi B+  
**OS:** Start with NOOBS on 8GB SD card  
**WiFi Adapter:** Belkin Model F7D2102  

Note - these directions are that maddening mix between assuming you know what you're doing and being too wordy.

Note - In the shell commands below, rather than including the 'sudo' part each time, just do ``sudo -s`` to open a root shell and not have to keep typing 'sudo'. Pretty much everything has to be done as root.

1. Plug Pi into wired MITnet (we'll use DHCP)
1. Create a NOOBS install card
1. Install NOOBS
	1. Set Language: English (US)
	1. Set keyboard: US
	1. Install Raspbian
	1. In the configuration screen (or run ``sudo raspi-config``) here are the options:
		1. Expand Filesystem - this doesn't need doing
		1. Change User Password - change this!!!!
		1. Enable Boot to Desktop/Scratch - don't do anything
		1. Internationalisation Options
			1. Change Locale - Do this, use the down-arrow to get to en_US.UTF-8. Hit the space bar to select it. Hit TAB to highlight the "OK". Hit RETURN. On the next screen, down-arrow to en_US.UTF-8. Hit RETURN.
			1. Change Timezone - set it to whatever you like. US Eastern is good for some of us...
			1. Change Keyboard Layout - this should be ok as is.
		1. Enable Camera - don't do this
		1. Add to Rastrack - don't do this
		1. Overclock - don't do this
		1. Advanced Options - enable SSH. Don't do anything else.
1. After you're done with the configuration, stay at the shell prompt, don't go into the desktop. You should be able to get at the internet via the wired net.
1. Update the OS (as root) 
``apt-get update && apt-get upgrade``
1. Install the following packages  
``apt-get install iw isc-dhcp-server hostapd apache2``
Note that you'll see a message that says the ISC DHCP server failed to start. That's ok. We'll fix it later.
1. Optionally install emacs (how can you live without it?!)  
``apt-get install emacs``
1. Grab the modified hostapd from Adafruit  
``wget http://www.adafruit.com/downloads/adafruit_hostapd.zip``  
``unzip adafruit_hostapd.zip``  
``sudo mv /usr/sbin/hostapd /usr/sbin/hostapd.ORIG``  
``sudo mv hostapd /usr/sbin``  
``sudo chmod 755 /usr/sbin/hostapd``  


Credits  
https://decryption.wordpress.com/2014/05/24/a-very-simple-way-to-use-a-raspberry-pi-as-a-wireless-access-point-not-a-router-with-an-rtl8192cu-based-wi-fi-chipset/