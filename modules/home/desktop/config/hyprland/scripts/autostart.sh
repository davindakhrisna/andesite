#!/usr/bin/env bash
# Hyprland Autostart Services

# 1. Displays & Kanshi
if command -v kanshi >/dev/null 2>&1; then
    pgrep -x "kanshi" >/dev/null || kanshi &
fi

# 2. Wallpaper Daemon (awww)
if command -v awww-daemon >/dev/null 2>&1; then
    pgrep -x "awww-daemon" >/dev/null || awww-daemon &
fi

# 3. Idle & Screen Locker Daemon
if command -v hypridle >/dev/null 2>&1; then
    pgrep -x "hypridle" >/dev/null || hypridle &
fi

# 4. Polkit Authentication Agent (GUI Password Prompt)
POLKIT_AGENT=$(find /run/current-system/sw/libexec /etc/profiles/per-user/"$USER"/libexec -name "*polkit*authentication-agent-1" 2>/dev/null | head -n 1)
if [ -n "$POLKIT_AGENT" ] && [ -x "$POLKIT_AGENT" ]; then
    pgrep -f "polkit.*authentication-agent-1" >/dev/null || "$POLKIT_AGENT" &
fi

# 5. Clipboard History Daemon
if command -v wl-paste >/dev/null 2>&1 && command -v cliphist >/dev/null 2>&1; then
    pgrep -f "wl-paste --type text --watch cliphist store" >/dev/null || wl-paste --type text --watch cliphist store &
    pgrep -f "wl-paste --type image --watch cliphist store" >/dev/null || wl-paste --type image --watch cliphist store &
fi

# 6. Status Bar / Quickshell
if command -v quickshell >/dev/null 2>&1; then
    pgrep -x "quickshell" >/dev/null || quickshell &
fi
