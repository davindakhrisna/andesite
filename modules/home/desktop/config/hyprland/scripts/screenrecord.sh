#!/usr/bin/env bash
# Wayland Screen Recorder Toggle (wl-screenrec + slurp)

REC_PID=$(pgrep -x "wl-screenrec")

if [ -n "$REC_PID" ]; then
    # Stop recording
    kill -INT "$REC_PID"
    notify-send -u normal "Screen Recording" "Perekaman layar dihentikan dan disimpan."
    exit 0
fi

SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
FILENAME="$SAVE_DIR/recording_${TIMESTAMP}.mp4"

GEOM=$(slurp)
[ -z "$GEOM" ] && exit 0

notify-send -u normal "Screen Recording" "Perekaman layar dimulai..."

wl-screenrec -g "$GEOM" -f "$FILENAME" --audio &
