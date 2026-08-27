#!/usr/bin/env bash
# Wayland Screenshot Toolkit (grim + slurp + wl-copy + swappy/satty)

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
FILENAME="$SAVE_DIR/screenshot_${TIMESTAMP}.png"

MODE="${1:-area}"

case "$MODE" in
    area)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send -i "$FILENAME" "Screenshot Area Saved" "Tersimpan di $FILENAME dan tersalin ke clipboard"
        ;;
    full)
        grim "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send -i "$FILENAME" "Full Screenshot Saved" "Tersimpan di $FILENAME dan tersalin ke clipboard"
        ;;
    clip)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" - | wl-copy
        notify-send "Screenshot Copied" "Screenshot tersalin ke clipboard"
        ;;
    swappy)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" - | swappy -f -
        ;;
    satty)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" - | satty --filename - --output-filename "$FILENAME"
        ;;
    *)
        grim "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send -i "$FILENAME" "Screenshot Saved" "Tersimpan di $FILENAME"
        ;;
esac
