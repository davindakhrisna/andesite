#!/usr/bin/env bash
# ==============================================================================
# Flint Desktop Theme Mode & Palette Switcher (Rofi)
# ==============================================================================

CACHE_MODE="${HOME}/.cache/flint-theme-mode"
CACHE_WALL="${HOME}/.cache/flint-wallpaper"
FLINT_DIR="${FLINT_DIR:-${HOME}/.config/flint}"
WALLPAPER_DIR="${FLINT_DIR}/wallpapers"

# 1. Detect active wallpaper
CURRENT_WALLPAPER=""
if [ -f "$CACHE_WALL" ]; then
    CURRENT_WALLPAPER=$(cat "$CACHE_WALL")
fi

if [ -z "$CURRENT_WALLPAPER" ] || [ ! -f "$CURRENT_WALLPAPER" ]; then
    CURRENT_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | head -n 1)
fi

if [ -z "$CURRENT_WALLPAPER" ] || [ ! -f "$CURRENT_WALLPAPER" ]; then
    notify-send -u critical "Theme Switcher" "No wallpaper found to extract palette from."
    exit 1
fi

# 2. Options menu
MODES=(
    "🌙 Dark Mode       (Default full dark palette)|dark16|prefer-dark"
    "☀️ Light Mode      (Clean bright day palette)|light16|prefer-light"
    "🌌 Soft Dark       (Low-contrast subtle dark)|softdark|prefer-dark"
    "💎 Hard Dark       (High-contrast OLED dark)|harddark|prefer-dark"
)

OPTIONS=""
for item in "${MODES[@]}"; do
    NAME="${item%%|*}"
    OPTIONS="${OPTIONS}${NAME}\n"
done

# 3. Show Rofi Dialog
CHOICE=$(echo -e -n "$OPTIONS" | rofi -dmenu \
    -p "Theme Mode" \
    -mesg "Select color palette mode for $(basename "$CURRENT_WALLPAPER")" \
    -theme-str 'window { width: 480px; } listview { lines: 4; }')

[ -z "$CHOICE" ] && exit 0

# 4. Extract parameters
PALETTE=""
GTK_PREF=""
CLEAN_NAME=""

for item in "${MODES[@]}"; do
    NAME="${item%%|*}"
    REST="${item#*|}"
    PAL="${REST%%|*}"
    GTK="${REST##*|}"

    if [ "$NAME" = "$CHOICE" ]; then
        PALETTE="$PAL"
        GTK_PREF="$GTK"
        CLEAN_NAME=$(echo "$NAME" | awk -F'(' '{print $1}' | sed 's/[ \t]*$//')
        break
    fi
done

[ -z "$PALETTE" ] && exit 0

# 5. Run Wallust with selected palette
mkdir -p "${HOME}/.cache/wallust"
WALLUST_CONF="${FLINT_DIR}/modules/home/desktop/config/wallust/wallust.toml"
if [ -f "$WALLUST_CONF" ]; then
    wallust run -C "$WALLUST_CONF" -p "$PALETTE" "$CURRENT_WALLPAPER"
else
    wallust run -p "$PALETTE" "$CURRENT_WALLPAPER"
fi

# Save mode state
echo "$PALETTE" > "$CACHE_MODE"

# 6. Update GTK Color Scheme
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface color-scheme "$GTK_PREF" 2>/dev/null || true
fi

# 7. Reload Desktop Daemons
# Waybar reload
pkill -SIGUSR2 waybar 2>/dev/null || true

# Dunst reload
if command -v dunstctl >/dev/null 2>&1; then
    dunstctl reload 2>/dev/null || true
fi

# Hyprland reload (for border colors)
if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload 2>/dev/null || true
fi

# SwayOSD server reload
pkill -SIGUSR2 swayosd-server 2>/dev/null || true

# Notify
notify-send -u low -i preferences-desktop-theme \
    "Theme Switcher" "Applied <b>${CLEAN_NAME}</b> theme mode"
