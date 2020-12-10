#!/bin/sh

# show start notification
dunstify -t 2000 -i bluetooth-online -a "Bluetooth" "Scanning..."

# setup bluetooth
sudo systemctl start bluetooth
bluetoothctl power on
bluetoothctl default-agent
timeout 2 bluetoothctl scan on

# show menu
devicename=$(bluetoothctl devices | cut -d" " -f 3- | dmenu)
deviceid=$(bluetoothctl devices | grep "$devicename" | cut -d" " -f 2)
bluetoothctl connect $deviceid
