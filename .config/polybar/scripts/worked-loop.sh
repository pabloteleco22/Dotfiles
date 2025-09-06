#!/usr/bin/env bash

function loop() {
    while true; do
        polybar-msg action worked-ipc hook 0
        sleep 60;
    done
}

pid_to_kill=$(ps -eo pid,ppid,command | sed "/$$/d" | awk "!/awk/ && /$(basename $0)/{print \$1}")

for p in $pid_to_kill; do
    echo Killing $p
    kill -KILL $p
done

loop &
