#!/usr/bin/env bash

# Export PATH with system fallbacks
export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

# Ensure dunst daemon is running
if ! pgrep -x "dunst" > /dev/null; then
    dunst -config "${HOME}/.config/flint/modules/home/desktop/config/dunst/dunstrc" &
    sleep 0.2
fi

# Toggle hyprsunset color temperature
if pgrep -x "hyprsunset" > /dev/null; then
    pkill -x "hyprsunset"
    notify-send -a "Night Light" -i display-brightness "Night Light: Deactivated" "Standard color temperature (6500K)" 2>/dev/null || true
else
    hyprsunset -t 4200 &
    notify-send -a "Night Light" -i night-light "Night Light: Activated" "Warm color temperature (4200K)" 2>/dev/null || true
fi
