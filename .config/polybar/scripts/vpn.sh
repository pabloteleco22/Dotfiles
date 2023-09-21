#!/usr/bin/bash

ip=$(ip a s proton0 2> /dev/null | grep -Eio "inet [0-9.]+" | grep -Eo [0-9.]+)

if test "$ip" != ""; then
    echo $ip
else
    echo off
fi
