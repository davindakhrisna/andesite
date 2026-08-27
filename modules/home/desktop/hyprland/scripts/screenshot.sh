#!/usr/bin/env bash

DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
    full)
        grim "$FILE" && wl-copy < "$FILE" && notify-send -i "$FILE" "Screenshot" "Full screen saved and copied to clipboard"
        ;;
    clip)
        geometry=$(slurp)
        [ -z "$geometry" ] && exit 0
        grim -g "$geometry" - | wl-copy --type image/png && notify-send "Screenshot" "Area copied to clipboard"
        ;;
    swappy)
        geometry=$(slurp)
        [ -z "$geometry" ] && exit 0
        grim -g "$geometry" - | swappy -f -
        ;;
    area|*)
        geometry=$(slurp)
        [ -z "$geometry" ] && exit 0
        grim -g "$geometry" - | satty --filename - --output-filename "$FILE" --early-exit --copy-command "wl-copy"
        ;;
esac
