#!/usr/bin/env bash
# Wallpaper & Theme Switcher (awww + wallust)

# 1. Pastikan awww-daemon berjalan
if ! pgrep -x "awww-daemon" >/dev/null; then
    awww-daemon &
    sleep 0.5
fi

# 2. Direktori wallpaper yang dicari
WALL_DIRS=(
    "$HOME/Pictures/Wallpapers"
    "$HOME/Pictures/wallpapers"
    "$HOME/Pictures"
    "$HOME/Wallpapers"
    "$HOME/.config/flint/themes/wallpapers"
)

# 3. Ambil argumen gambar atau buka Rofi selector
TARGET_WALL=""

if [ -n "$1" ] && [ -f "$1" ]; then
    TARGET_WALL="$1"
else
    # Kumpulkan semua wallpaper yang ada
    FOUND_WALLS=()
    for d in "${WALL_DIRS[@]}"; do
        if [ -d "$d" ]; then
            while IFS= read -r f; do
                [ -n "$f" ] && FOUND_WALLS+=("$f")
            done < <(find "$d" -maxdepth 2 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" -o -name "*.gif" \) 2>/dev/null)
        fi
    done

    if [ ${#FOUND_WALLS[@]} -eq 0 ]; then
        # Jika belum ada folder wallpaper, minta pilih via dialog file atau buat folder
        mkdir -p "$HOME/Pictures/Wallpapers"
        notify-send "Wallust Switcher" "Simpan file wallpaper di ~/Pictures/Wallpapers lalu jalankan lagi."
        exit 0
    fi

    # Format list untuk Rofi
    SELECTED_NAME=$(printf '%s\n' "${FOUND_WALLS[@]}" | sed "s|$HOME/||" | rofi -dmenu -p "WALLPAPER" -i)
    [ -z "$SELECTED_NAME" ] && exit 0
    TARGET_WALL="$HOME/$SELECTED_NAME"
fi

if [ ! -f "$TARGET_WALL" ]; then
    notify-send "Error" "Wallpaper tidak ditemukan: $TARGET_WALL"
    exit 1
fi

# 4. Ganti wallpaper via awww
awww img "$TARGET_WALL"

# Simpan salinan untuk background statis Hyprlock (bebas lag screenshot)
mkdir -p "$HOME/.config/hypr"
cp "$TARGET_WALL" "$HOME/.config/hypr/wallpaper.png" 2>/dev/null || true

# 5. Ekstrak warna dan perbarui tema GTK, Kitty, Rofi via Wallust
if command -v wallust >/dev/null 2>&1; then
    wallust run "$TARGET_WALL"
    
    # Reload Kitty instance yang sedang terbuka
    killall -SIGUSR1 kitty 2>/dev/null || true
    
    # Reload Dunst notification daemon
    killall -SIGUSR1 dunst 2>/dev/null || true
    
    # Reload Hyprland jika diperlukan
    hyprctl reload 2>/dev/null || true

    notify-send "Wallust Theming" "Tema sistem berhasil disinkronkan dengan wallpaper!"
fi
