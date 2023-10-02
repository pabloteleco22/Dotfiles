#!/usr/bin/bash

caps=$(xset q | awk '{if (match($0, /Caps Lock:\s+(on|off)/, res) > 0) print res[1]}')


num=$(xset q | awk '{if (match($0, /Num Lock:\s+(on|off)/, res) > 0) print res[1]}')

touchpad_id=$(xinput list | grep -Eio "touchpad\s*id=[0-9]+" | grep -Eo "[0-9]+")

begin="%{uFFFF00}%{+u}"
caps_label="%{O6}󰘶%{O2}"
num_label="%{O6}%{T5}󰎠%{T-}%{O9}"
touchpad_label="%{T5}󰝁%{T-}%{O4}"
end="%{u-}"

return=$begin

if test "$caps" = "on"; then
    return="$return$caps_label"
fi

if test "$num" = "on"; then
    return="$return$num_label"
fi

if test "$(xinput list-props $touchpad_id | grep -Eio "device enabled.*:\s*[01]" | awk -v FS=: '{print $2}' | xargs)" = "1"; then
    return="$return$touchpad_label"
fi

if test "$return" = "$begin$caps_label"; then
    return="$return%{O6}"
elif test "$return" = "$begin$touchpad_label"; then
    return="$begin%{O6}$touchpad_label"
fi

return="$return$end"

echo $return
