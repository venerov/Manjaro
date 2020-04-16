#!/bin/bash
bus=$(lsusb | grep Xbox360 | gawk '{print $2}')
port=$(lsusb | grep Xbox360 | gawk '{print $4}' | cut -d":" -f1)
sudo usbreset /dev/bus/usb/$bus/$port
