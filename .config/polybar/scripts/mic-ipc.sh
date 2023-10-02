#!/usr/bin/bash

if test "$1" == "toggle"; then
    pulsemixer --toggle-mute --id source-1
fi

if test "$(pulsemixer --get-mute --id source-1)" = "0"; then
    echo "%{O8}%{O9}"
else
    echo "%{O6}%{O9}"
fi
