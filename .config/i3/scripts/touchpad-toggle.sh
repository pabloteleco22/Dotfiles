#!/usr/bin/bash

device_id=$(xinput list | grep -Eio "touchpad\s*id=[0-9]+" | grep -Eo "[0-9]+")
notification_message=""

if test $(xinput list-props $device_id | grep -Eio "device enabled.*:\s*[01]" | awk -v FS=: '{print $2}' | xargs) = 0; then
    xinput enable $device_id
    #notification_message="Panel táctil activado"
else
    xinput disable $device_id
    #notification_message="Panel táctil desactivado"
fi

notify-send -r 1 "$notification_message"
