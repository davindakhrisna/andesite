#!/usr/bin/env bash

# Export PATH with user profiles and system fallbacks
export PATH="/nix/store/75mgj6095m874gm4pswsk5j6c123af64-dunst-1.13.2/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

# Ensure dunst daemon is running
if ! pgrep -x "dunst" > /dev/null; then
    dunst -config "${HOME}/.config/flint/modules/home/desktop/config/dunst/dunstrc" &
    sleep 0.2
fi

# Screenshot Directory
DIR="${HOME}/Pictures/Screenshots"
mkdir -p "$DIR"

MODE="${1:-region}"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="${DIR}/screenshot_${TIMESTAMP}.png"

case "$MODE" in
    region|area|select)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" "$FILE"
        ;;
    full|screen)
        grim "$FILE"
        ;;
    window|active)
        GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' 2>/dev/null)
        if [ -z "$GEOM" ] || [ "$GEOM" = "null" ]; then
            grim "$FILE"
        else
            grim -g "$GEOM" "$FILE"
        fi
        ;;
    *)
        grim -g "$(slurp)" "$FILE"
        ;;
esac

# 1. MUST copy to clipboard FIRST
if [ -f "$FILE" ]; then
    wl-copy < "$FILE"
    notify-send -i "$FILE" "Screenshot Copied" "Copied to clipboard & opening in Satty..." 2>/dev/null || true

    # 2. THEN open in Satty annotation suite
    if command -v satty >/dev/null 2>&1; then
        satty --filename "$FILE" --output-filename "$FILE" &
    elif command -v swappy >/dev/null 2>&1; then
        swappy -f "$FILE" &
    fi
fi
