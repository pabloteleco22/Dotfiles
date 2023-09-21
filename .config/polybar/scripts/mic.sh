#!/usr/bin/bash

if test "$1" == "toggle"; then
    pulsemixer --toggle-mute --id source-1
else
    if test "$(pulsemixer --get-mute --id source-1)" = "0"; then
        echo ""
    else
        echo ""
    fi
fi
