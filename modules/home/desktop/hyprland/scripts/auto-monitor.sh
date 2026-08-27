#!/usr/bin/env bash

# Function to auto-configure all connected monitors to highest resolution & refresh rate
configure_monitors() {
    hyprctl monitors all -j | jq -r '.[] | .name' | while read -r name; do
        hyprctl keyword monitor "$name,preferred,auto,1"
    done
}

# Run once immediately on launch
configure_monitors

# Listen for monitor hotplug events
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

if [ -S "$SOCKET" ]; then
    nc -U "$SOCKET" | while read -r line; do
        case "$line" in
            monitoradded*|monitorremoved*)
                sleep 0.5
                configure_monitors
                ;;
        esac
    done
fi
