#!/usr/bin/env bash
# Blue Light / Night Light Filter Toggle (hyprsunset)

PID=$(pgrep -x "hyprsunset" || pgrep -x "wlsunset")

if [ -n "$PID" ]; then
    killall hyprsunset 2>/dev/null || killall wlsunset 2>/dev/null || true
    notify-send -u low "Night Light" "Filter cahaya biru dimatikan (6500K Normal)"
else
    if command -v hyprsunset >/dev/null 2>&1; then
        hyprsunset -t 4200 &
        notify-send -u low "Night Light" "Filter cahaya biru aktif (4200K Hangat)"
    elif command -v wlsunset >/dev/null 2>&1; then
        wlsunset -t 4200 -T 6500 &
        notify-send -u low "Night Light" "Filter cahaya biru aktif (4200K Hangat)"
    fi
fi
