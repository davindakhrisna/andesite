#!/usr/bin/env bash

ACTION="${1:-toggle}"

case "$ACTION" in
    start)
        if ! pgrep -f "class screensaver" > /dev/null && ! pgrep -x "cmatrix" > /dev/null; then
            kitty --class screensaver --start-as=fullscreen -e cmatrix -b -s &
        fi
        ;;
    stop)
        pkill -f "class screensaver" 2>/dev/null || true
        pkill -x "cmatrix" 2>/dev/null || true
        hyprctl dispatch closewindow class:screensaver 2>/dev/null || true
        ;;
    toggle)
        if pgrep -f "class screensaver" > /dev/null || pgrep -x "cmatrix" > /dev/null; then
            $0 stop
        else
            $0 start
        fi
        ;;
esac
