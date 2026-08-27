#!/usr/bin/env bash

# Export PATH with system profiles and nix store fallbacks
export PATH="/nix/store/q9bi7cj4j1g8mgh36ykx3l9mki390wbc-awww-0.12.1/bin:/nix/store/7p2j2336adkny7irak2ki7l9jlywhf19-wallust-3.5.2/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

# Wallpaper Directories
WALLPAPER_DIR="${HOME}/.config/flint/wallpapers"
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
    -mesg "Select wallpaper to apply" \
    -show-icons \
    -theme-str '
    * {
        font: "Iosevka Nerd Font 12";
    }
    window {
        location: center;
        anchor: center;
        width: 780px;
        border: 2px solid;
        padding: 12px;
    }
    mainbox {
        spacing: 8px;
        children: [ inputbar, listview, message ];
    }
    inputbar {
        padding: 8px 12px;
        children: [ prompt, entry ];
    }
    prompt {
        font: "Iosevka Nerd Font Bold 12";
        margin: 0px 8px 0px 0px;
    }
    entry {
        placeholder: "Type to filter...";
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
        padding: 8px;
        spacing: 6px;
    }
    element-icon {
        size: 5.5em;
        horizontal-align: 0.5;
        vertical-align: 0.5;
    }
    element-text {
        horizontal-align: 0.5;
        vertical-align: 0.5;
    }
    message {
        padding: 6px 12px;
    }
    textbox {
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
    # Ensure awww daemon is running
    if ! pgrep -f "awww-daemon" > /dev/null; then
        awww-daemon &
        sleep 0.3
    fi

    # Set wallpaper using awww
    awww img "$selected_path" --transition-type any --transition-step 90 || awww "$selected_path"

    # Generate color scheme with wallust
    if command -v wallust >/dev/null 2>&1; then
        wallust run "$selected_path"
    fi

    notify-send "Wallpaper Switcher" "Applied: $(basename "$selected_path")" 2>/dev/null || true
fi
