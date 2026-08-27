#!/usr/bin/env bash

DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$DIR"
FILE="$DIR/recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

if pgrep -x "wl-screenrec" > /dev/null; then
    pkill -INT -x "wl-screenrec"
    notify-send "Screen Recording" "Recording stopped and saved"
else
    geometry=$(slurp)
    [ -z "$geometry" ] && exit 0
    notify-send "Screen Recording" "Recording started..."
    wl-screenrec -g "$geometry" -f "$FILE" --audio
fi
