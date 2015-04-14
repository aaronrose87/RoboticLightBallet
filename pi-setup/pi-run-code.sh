#!/bin/bash

# Assumes the pi has been set up and the code has been installed.

sleep 10

while true; do
    cd ~pi/RoboticLightBallet/pi-code
    python robotControl.py

    # sleep is here just to make sure that if something goes
    # horribly wrong, there might be enough CPU cycles left
    # to ssh in and do something
    sleep 10
done



    
