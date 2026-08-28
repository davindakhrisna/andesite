#!/usr/bin/env bash

# Export PATH with system fallbacks
export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

FLINT_DIR="${FLINT_DIR:-${HOME}/.config/flint}"

# Ensure dunst daemon is running
if ! pgrep -x "dunst" > /dev/null; then
    dunst -config "${FLINT_DIR}/modules/home/desktop/config/dunst/dunstrc" &
    sleep 0.2
fi

STATUS=$(hyprctl getoption animations:enabled -j 2>/dev/null | jq -r '.bool' 2>/dev/null)

if [ "$STATUS" = "true" ]; then
    # Enable Game Mode: disable animations, blur, gaps
    hyprctl eval 'hl.config({
        animations = { enabled = false },
        decoration = {
            blur = { enabled = false },
            shadow = { enabled = false },
            rounding = 0
        },
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 1
        }
    })' > /dev/null 2>&1

    notify-send -a "Game Mode" -i input-gaming "Game Mode: ENABLED" "Animations & effects disabled for max performance" 2>/dev/null || true
else
    # Disable Game Mode: restore normal effects and gaps
    hyprctl eval 'hl.config({
        animations = { enabled = true },
        decoration = {
            blur = { enabled = true, size = 5, passes = 2, new_optimizations = true, xray = false },
            shadow = { enabled = false },
            rounding = 0
        },
        general = {
            gaps_in = 12,
            gaps_out = 32,
            border_size = 1
        }
    })' > /dev/null 2>&1

    notify-send -a "Game Mode" -i video-display "Game Mode: DISABLED" "Visual effects & animations restored" 2>/dev/null || true
fi
