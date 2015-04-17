# How to set up the Raspberry Pi

## Assumptions
These directions are specific to the Robotic Light Ballet project in the [MIT Museum Studio](http://mitmuseumstudio.mit.edu). If you're coming here from "outside", note that not all the choices below will make sense for you. Fork this repo and edit for your own purposes.

## Result
These instructions result in the following:

* One Pi as a control computer (aka the Control Pi)
	* It can have a display and keyboard
	* It can be connected to a wired network for remote access.
	* It sets up a WiFi access point with SSID 'studiobot' and password 'lightballet'
	* It provides DHCP service
	* There is no bridge or router from the wired to wireless. If you want to talk to a client, you ssh in to this Pi and then ssh from there to the others.

* One or more Pi's set up to be on the studiobot network (aka the Robot Pi's)
	* They pick up IP addresses from the access point.
	* They can be on a wired network for development and debugging

* Devices that connect to the control Pi are given IP addresses in the range 10.10.0.1 to 10.10.0.10.

## Prerequisites
* Raspberry Pi 2 (tested on Raspberry Pi 2 Model B v1.1)  
Also works on a Pi B+
* NOOBS on 8GB SD card
* Belkin Model F7D2102 USB Wifi adapter
* For installation: Plugged in to wired ethernet and able to pick up an IP address via DHCP

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
 
# Setup for Control Pi

Remember to be root.

``wget --no-check-certificate -O pi-setup-controller.sh http://goo.gl/z9Gw1J``

The goo.gl link picks up https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup-controller.sh

``bash ./pi-setup-controller.sh``

If you want to see what's going on, use ``bash -x``

When this script is done, the Pi is up and running as an access point. Actual control code is not loaded at this point.

# Setup for Robot Pi

Remember to be root.

``wget --no-check-certificate -O pi-setup-robot.sh http://goo.gl/xxpjpz``

The goo.gl link picks up https://raw.githubusercontent.com/mitmuseumstudio/RoboticLightBallet/master/pi-setup/pi-setup-robot.sh

``bash ./pi-setup-robot.sh``

If you want to see what's going on, use ``bash -x``

When this script is done, the Pi is up and running as a client. Access control code is not loaded at this point.

#Warnings
* If the controller Pi is plugged into a wired network that happens to be an internal network behind a router, and is given a wired IP address in the 10.10.0.x range, things could behave badly.

# Credits  
https://decryption.wordpress.com/2014/05/24/a-very-simple-way-to-use-a-raspberry-pi-as-a-wireless-access-point-not-a-router-with-an-rtl8192cu-based-wi-fi-chipset/