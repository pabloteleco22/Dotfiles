#!/usr/bin/env bash

get-current-workspace() {
    echo $(i3-msg -t get_workspaces | grep -Eio "num[a-zA-Z0-9:\",]*focused\":true" | grep -Eo "[0-9]+" | head -n1)
}

exec-command() {
    case $2 in
        next)
            $1 $(($(get-current-workspace)+1))
            ;;
        prev)
            current_workspace=$(get-current-workspace)
            if test "$current_workspace" != "1"; then
                $1 $(($(get-current-workspace)-1))
            fi
            ;;
    esac
}

case $1 in
    m)
        shift
        exec-command "i3-msg workspace" $1
        ;;
    mc)
        shift
        exec-command "i3-msg move container to workspace " $1
        exec-command "i3-msg workspace" $1
        ;;
esac
