#!/usr/bin/env bash
# Auto-configure displays with kanshi or hyprctl fallback

if command -v kanshi >/dev/null 2>&1; then
    # Jika kanshi sudah berjalan, reload
    if pgrep -x "kanshi" >/dev/null; then
        killall -SIGUSR1 kanshi 2>/dev/null || true
    else
        kanshi &
    fi
fi
