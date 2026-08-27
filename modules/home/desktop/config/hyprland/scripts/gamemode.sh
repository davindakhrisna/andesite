#!/usr/bin/env bash
# Hyprland Gamemode Toggle (Max Performance / Disable Animations & Blur)

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = "1" ]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:rounding 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:drop_shadow 0"
    notify-send -u normal "Gamemode" "Gamemode ON (Semua animasi & blur dimatikan untuk performa maksimal)"
    exit 0
else
    hyprctl reload
    notify-send -u normal "Gamemode" "Gamemode OFF (Estetika visual & tema dikembalikan)"
    exit 0
fi
