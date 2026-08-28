#!/usr/bin/env bash
# ==============================================================================
# Hyprland Animation Switcher (Rofi)
# Switches between distinct animation presets dynamically
# ==============================================================================

FLINT_DIR="${FLINT_DIR:-${HOME}/.config/flint}"
PRESET_DIR="${FLINT_DIR}/modules/home/desktop/config/hyprland/animation-presets"
TARGET_FILE="${FLINT_DIR}/modules/home/desktop/config/hyprland/animations.lua"

# Define available presets: "Display Name|Preset File"
PRESETS=(
    "🌊 Fluid & Smooth      (Default silky-smooth motion)|fluid.lua"
    "⚡ Fast & Snappy       (Ultra-fast responsive motion)|snappy.lua"
    "🎾 Spring & Bouncy     (Playful overshoot bounce physics)|bouncy.lua"
    "🌫️ Subtle & Minimal    (Gentle fade-heavy transitions)|subtle.lua"
    "⛔ Disabled (Max FPS)  (Instant snapping without delay)|disabled.lua"
)

# Build Rofi options list
OPTIONS=""
for item in "${PRESETS[@]}"; do
    NAME="${item%%|*}"
    OPTIONS="${OPTIONS}${NAME}\n"
done

# Show Rofi Menu
CHOICE=$(echo -e -n "$OPTIONS" | rofi -dmenu \
    -p "Animations" \
    -theme-str 'window { width: 520px; } listview { lines: 6; }')

[ -z "$CHOICE" ] && exit 0

# Match choice to preset file
SELECTED_FILE=""
CLEAN_NAME=""
for item in "${PRESETS[@]}"; do
    NAME="${item%%|*}"
    FILE="${item##*|}"
    if [ "$NAME" = "$CHOICE" ]; then
        SELECTED_FILE="$FILE"
        CLEAN_NAME=$(echo "$NAME" | awk -F'(' '{print $1}' | sed 's/[ \t]*$//')
        break
    fi
done

if [ -n "$SELECTED_FILE" ] && [ -f "$PRESET_DIR/$SELECTED_FILE" ]; then
    # 1. Update animations.lua
    cp "$PRESET_DIR/$SELECTED_FILE" "$TARGET_FILE"

    # 2. Hot-reload Hyprland configuration
    hyprctl reload >/dev/null 2>&1 || true

    # 3. Notify user
    notify-send -u low -i preferences-desktop-theme \
        "Hyprland Animations" "Activated preset: <b>${CLEAN_NAME}</b>"
fi
