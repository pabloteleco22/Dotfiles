#!/usr/bin/bash

pol_interval=1

if test "$1" != ""; then
    pol_interval=$1
fi

while true; do
    polybar-msg action mic-ipc hook 0
    sleep $pol_interval
done
