#!/usr/bin/env bash
# Hyprland Keybindings & Cheatsheet

CHEATSHEET="
⌨️  APPLICATIONS & SYSTEM
SUPER + RETURN          👉 Terminal (Kitty)
SUPER + Space / R       👉 App Launcher (Rofi)
SUPER + Q               👉 Close Active Window
SUPER + SHIFT + P       👉 Bitwarden Password Manager (Rofi)
SUPER + W               👉 Wallpaper & Theme Switcher (awww + wallust)
SUPER + Escape          👉 Power / Logout Menu (Wlogout)
SUPER + V               👉 Toggle Window Floating
SUPER + J               👉 Toggle Layout Split
SUPER + SHIFT + R       👉 Reload Hyprland Configuration

📟  TUI TOOLS (SCRATCHPADS)
SUPER + E               👉 File Manager (Yazi)
SUPER + SHIFT + E       👉 GUI File Manager (Thunar)
SUPER + A               👉 PipeWire Audio Mixer (Wiremix)
SUPER + B               👉 Bluetooth Manager (Bluetui)
SUPER + N               👉 WiFi Network Manager (Gazelle)
SUPER + D               👉 Monitor Layout & Settings (Hyprmon)
SUPER + T               👉 Quick Notes (Neovim)
SUPER + C               👉 Clipboard History Manager (Rofi)
SUPER + . (period)      👉 Emoji Picker (Rofimoji)
SUPER + F1              👉 Gamemode Toggle (Max FPS for Games)
SUPER + ALT + N         👉 Night Light / Blue Light Filter Toggle
SUPER + /               👉 Keybindings Cheatsheet

📸  SCREENSHOT & RECORDING
Print / SUPER+SHIFT+S   👉 Screenshot Area (Save to Pictures & Clipboard)
SHIFT + Print           👉 Screenshot Full Screen
CTRL + Print            👉 Screenshot Area to Clipboard Only
SUPER + Print           👉 Screenshot & Annotate (Swappy)
SUPER + ALT + R         👉 Toggle Screen Recording (wl-screenrec)

🪟  NAVIGATION
SUPER + Left/Right/Up/Down 👉 Focus Window
SUPER + 1..10             👉 Switch Workspace 1..10
SUPER + SHIFT + 1..10     👉 Move Window to Workspace 1..10
SUPER + Mouse Left Drag   👉 Move Window
SUPER + Mouse Right Drag  👉 Resize Window
"

echo -e "$CHEATSHEET" | grep -v '^[[:space:]]*$' | rofi -dmenu -i -p "CHEATSHEET" -theme-str 'window { width: 720px; } listview { lines: 18; }'
