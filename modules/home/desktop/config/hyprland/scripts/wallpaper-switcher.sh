#!/usr/bin/env bash

# Export PATH with system profiles and user binaries
export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

# Wallpaper Directories
FLINT_DIR="${FLINT_DIR:-${HOME}/.config/flint}"
WALLPAPER_DIR="${FLINT_DIR}/wallpapers"
FALLBACK_DIR="${HOME}/Pictures/Wallpapers"

mkdir -p "$WALLPAPER_DIR"

# Collect images
wallpapers=()
while IFS= read -r -d '' file; do
    wallpapers+=("$file")
done < <(find "$WALLPAPER_DIR" "$FALLBACK_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0 2>/dev/null | sort -z -u)

if [ ${#wallpapers[@]} -eq 0 ]; then
    rofi -e "No wallpapers found in $WALLPAPER_DIR or $FALLBACK_DIR. Please add images there."
    exit 1
fi

# Generate entries stream for Rofi
generate_entries() {
    for img in "${wallpapers[@]}"; do
        filename=$(basename "$img")
        name="${filename%.*}"
        printf "%s\0icon\x1f%s\n" "$name" "$img"
    done
}

# Launch Rofi grid with thumbnail preview
selected=$(generate_entries | rofi -dmenu \
    -p "Wallpaper" \
    -show-icons \
    -theme-str '
    window {
        location: center;
        anchor: center;
        width: 820px;
        border: 2px solid;
        border-color: @border-col;
        border-radius: 0px;
        background-color: @background;
        padding: 16px;
    }
    mainbox {
        spacing: 12px;
        children: [ inputbar, message, listview ];
    }
    inputbar {
        padding: 8px 12px;
        background-color: @background-alt;
        border: 1px solid;
        border-color: @border-col;
        border-radius: 0px;
        children: [ prompt, entry ];
    }
    prompt {
        font: "Iosevka Nerd Font Bold 12";
        text-color: @primary;
        margin: 0px 8px 0px 0px;
    }
    entry {
        text-color: @foreground;
        placeholder: "Type to filter...";
        placeholder-color: @border-col;
    }
    listview {
        lines: 2;
        columns: 4;
        scrollbar: false;
        spacing: 10px;
        padding: 8px 0px;
        fixed-height: false;
        flow: horizontal;
    }
    element {
        orientation: vertical;
        padding: 10px;
        spacing: 8px;
        border-radius: 0px;
        background-color: transparent;
        text-color: @foreground;
    }
    element selected {
        background-color: @selected;
        text-color: @selected-fg;
    }
    element-icon {
        size: 5.5em;
        horizontal-align: 0.5;
    }
    element-text {
        horizontal-align: 0.5;
        text-color: inherit;
    }
    message {
        padding: 6px 12px;
        background-color: @background-alt;
        border: 1px solid;
        border-color: @border-col;
        border-radius: 0px;
    }
    textbox {
        text-color: @foreground;
        horizontal-align: 0.5;
        font: "Iosevka Nerd Font 10";
    }
    ')

[ -z "$selected" ] && exit 0

# Match selected name to full file path
selected_path=""
for img in "${wallpapers[@]}"; do
    filename=$(basename "$img")
    name="${filename%.*}"
    if [ "$name" = "$selected" ] || [ "$filename" = "$selected" ]; then
        selected_path="$img"
        break
    fi
done

# Fallback loose match if exact match failed
if [ -z "$selected_path" ]; then
    for img in "${wallpapers[@]}"; do
        if [[ "$img" == *"$selected"* ]]; then
            selected_path="$img"
            break
        fi
    done
fi

if [ -n "$selected_path" ] && [ -f "$selected_path" ]; then
    # Cache selected wallpaper path
    mkdir -p "${HOME}/.cache/wallust"
    echo "$selected_path" > "${HOME}/.cache/flint-wallpaper"

    # Ensure awww daemon is running
    if ! pgrep -f "awww-daemon" > /dev/null; then
        awww-daemon &
        sleep 0.3
    fi

    # Set wallpaper using awww
    awww img "$selected_path" --transition-type any --transition-step 90 || awww "$selected_path"

    # Generate color scheme with wallust using current mode
    THEME_MODE="dark16"
    if [ -f "${HOME}/.cache/flint-theme-mode" ]; then
        THEME_MODE=$(cat "${HOME}/.cache/flint-theme-mode")
    fi

    if command -v wallust >/dev/null 2>&1; then
        WALLUST_CONF="${FLINT_DIR}/modules/home/desktop/config/wallust/wallust.toml"
        if [ -f "$WALLUST_CONF" ]; then
            wallust run -C "$WALLUST_CONF" -p "$THEME_MODE" "$selected_path"
        else
            wallust run -p "$THEME_MODE" "$selected_path"
        fi
    fi

    # Reload all desktop daemons
    pkill -SIGUSR2 waybar 2>/dev/null || true
    if command -v dunstctl >/dev/null 2>&1; then
        dunstctl reload 2>/dev/null || true
    fi
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload 2>/dev/null || true
    fi
    pkill -SIGUSR2 swayosd-server 2>/dev/null || true

    notify-send -u low -i preferences-desktop-theme \
        "Wallpaper Switcher" "Applied: <b>$(basename "$selected_path")</b>" 2>/dev/null || true
fi
