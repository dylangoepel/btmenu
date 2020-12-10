#!/bin/sh

# show start notification
dunstify -t 2000 -i bluetooth-online -a "Bluetooth" "Scanning..."

# setup bluetooth
sudo systemctl start bluetooth
bluetoothctl power on
bluetoothctl default-agent
timeout 2 bluetoothctl scan on

function menu() {
    devicename=$( (bluetoothctl devices | cut -d" " -f 3-) | dmenu)

    if [ -z "$devicename" ]; then
        exit
    fi

    deviceid=$(bluetoothctl devices | grep "$devicename" | cut -d" " -f 2)
    msg=$(bluetoothctl connect $deviceid 2>&1)
    if [ $? -eq 0 ]; then
        dunstify -i bluetooth-online -a "Bluetooth" "Connected to $devicename."
    else
        dunstify -i bluetooth-online -a "Bluetooth" "$msg"
        menu
    fi
}

menu
