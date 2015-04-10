# How to set up the Raspberry Pi

## Assumptions
These directions are specific to the Robotic Light Ballet project in the [MIT Museum Studio](http://mitmuseumstudio.mit.edu). If you're coming here from "outside", note that not all the choices below will make sense for you. Fork this repo and edit for your own purposes.

## Result
These instructions result in the following:

* The Pi sets up a WiFi access point, with SSID 'studiobot'. The password is 'lightballet'. 
* There is no routing set up, if you need access to the external internet, you need to use the wired connection.
* Devices that connect to the pi are given IP addresses in the range 10.10.0.1 to 10.10.0.10.

## Prerequisites
* Raspberry Pi 2 (tested on Raspberry Pi 2 Model B v1.1)  
Also works on a Pi B+
* NOOBS on 8GB SD card
* Belkin Model F7D2102 USB Wifi adapter
* Plugged in to wired ethernet and able to pick up an IP address via DHCP

## Directions

These directions are that maddening mix between assuming you know what you're doing and being too wordy.

1. Plug Pi into wired ethernet (we'll use MITnet and DHCP)
1. Create a NOOBS install card
1. Install NOOBS and configure it. This list is the full customization, but you can get away with a bare minimum. That would be to just set up keyboard to US, password, and turn on ssh.
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
  
  This will pull down the latest setup script from the github repo and save it. (The goo.gl link resolves to https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup.sh) If you're paranoid, and there's no reason not to be, look at it before you run it.
  
  ``sudo bash ./pi-setup.sh``
  
At this point the Pi is set up to act as a WiFi access point.



Credits  
https://decryption.wordpress.com/2014/05/24/a-very-simple-way-to-use-a-raspberry-pi-as-a-wireless-access-point-not-a-router-with-an-rtl8192cu-based-wi-fi-chipset/