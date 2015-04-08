# How to set up the Raspberry Pi

**Pi:** Rasberry Pi B+  
**OS:** Start with NOOBS on 8GB SD card  
**WiFi Adapter:** Belkin Model F7D2102  

## Prerequisites
* Raspberry Pi B+
* Belkin Model F7D2102 USB Wifi adapter
* Plugged in to wired ethernet and able to pick up an IP address via DHCP


These directions are that maddening mix between assuming you know what you're doing and being too wordy.

1. Plug Pi into wired ethernet (we'll use MITnet and DHCP)
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
1. After you're done with the configuration, stay at the shell prompt, don't go into the desktop. You should be able to get at the internet via the wired net. Either use **sudo** as shown in each command, or open a root shell via **sudo -s**   
  
  ``sudo wget --no-check-certificate -O pi-setup.sh http://goo.gl/58aOPA``   
  
  This will pull down the latest setup script from the github repo and save it. If you're paranoid, and there's no reason not to be, look at it before you run it.
  
  ``sudo bash ./pi-setup.sh``
  




Credits  
https://decryption.wordpress.com/2014/05/24/a-very-simple-way-to-use-a-raspberry-pi-as-a-wireless-access-point-not-a-router-with-an-rtl8192cu-based-wi-fi-chipset/