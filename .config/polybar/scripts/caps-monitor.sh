#!/usr/bin/bash

keyboard_id=$(xinput list | grep -Ei "at translated set 2 keyboard\s*id=[0-9]+" | grep -Eio "id=[0-9]+" | grep -Eio "[0-9]+")

caps_code=66
num_code=77
touchpad_code=199

xinput test $keyboard_id |
    while read line; do
        code=$(echo $line | awk '{if (match($0, /release/)) {print $3} else {print "false"}}')
        if test "$code" != "false"; then
            if test "$code" = "$caps_code" -o \
                    "$code" = "$num_code" -o \
                    "$code" = "$touchpad_code"; then
                polybar-msg action capsnumlock-ipc hook 0
                echo "evento"
            fi
        fi
    done
