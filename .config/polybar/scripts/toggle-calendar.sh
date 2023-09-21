#!/usr/bin/bash

pid=$(ps aux | grep -E "MyPythonCalendar.*launch-calendar.sh\$" | awk '{print $2}')

if test "$pid" != ""; then
    kill -TERM $pid
else
    /home/pablo/Programas/Python/MyPythonCalendar/launch-calendar.sh &
fi
