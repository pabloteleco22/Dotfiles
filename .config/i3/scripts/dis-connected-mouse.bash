#!/usr/bin/bash

touchpad_id=$(xinput list | grep -Eio "touchpad\s*id=[0-9]+" | grep -Eo "[0-9]+")

if test "$(xinput list | grep -i mouse)" != ""; then
    xinput disable $touchpad_id
    notify-send -r 1 "Ratón detectado" "Panel táctil desactivado"
fi

udevadm monitor --udev | while read -r line; do
    res="$(echo $line | awk 'match($0, /mouse/) { \
        if (match($0, /add/)) { \
            print "add" \
        } else if (match($0, /remove/)) { \
            print "remove" \
        }}')"

    if test "$res" = "add"; then
        xinput disable $touchpad_id
        notify-send -r 1 "Ratón detectado" "Panel táctil desactivado"
    elif test "$res" = "remove"; then
        xinput enable $touchpad_id
        notify-send -r 1 "Ratón no detectado" "Panel táctil activado"
    fi
done
