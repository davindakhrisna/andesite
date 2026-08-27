#!/usr/bin/env bash
# Clipboard History Manager with Rofi & Cliphist

ACTION="${1:-list}"

case "$ACTION" in
    clear)
        cliphist wipe
        notify-send -u normal "Clipboard" "Riwayat clipboard berhasil dibersihkan."
        ;;
    *)
        SELECTED=$(cliphist list | rofi -dmenu -i -p "CLIPBOARD" -theme-str 'window { width: 680px; } listview { lines: 12; }')
        if [ -n "$SELECTED" ]; then
            echo "$SELECTED" | cliphist decode | wl-copy
            notify-send -u low "Clipboard" "Tersalin ke clipboard."
        fi
        ;;
esac
