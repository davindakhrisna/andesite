#!/usr/bin/env bash
# ==============================================================================
# Auto Monitor Detection & Confirmation (Hyprland + Rofi)
# ==============================================================================

handle_monitor_added() {
    local mon_name="$1"
    
    # 1. Send Notification
    notify-send -u normal -i video-display \
        "🖥️ New Monitor Connected" "Detected display: <b>${mon_name}</b>\nPlease select layout."

    # 2. Prompt User via Rofi Modal Confirmation
    OPTIONS="➡️ Extend to Right (auto-right)\n⬅️ Extend to Left (auto-left)\n⬆️ Extend to Top (auto-up)\n🖥️ Mirror Primary Display\n💻 External Display Only\n❌ Ignore / Keep Current"

    CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu \
        -p "Display" \
        -mesg "Configure new monitor: $mon_name" \
        -theme-str 'window { width: 480px; } listview { lines: 6; }')

    case "$CHOICE" in
        *"Extend to Right"*)
            hyprctl keyword monitor "${mon_name},preferred,auto-right,1"
            notify-send -u low -i video-display "Display Configured" "Extended <b>${mon_name}</b> to the right"
            ;;
        *"Extend to Left"*)
            hyprctl keyword monitor "${mon_name},preferred,auto-left,1"
            notify-send -u low -i video-display "Display Configured" "Extended <b>${mon_name}</b> to the left"
            ;;
        *"Extend to Top"*)
            hyprctl keyword monitor "${mon_name},preferred,auto-up,1"
            notify-send -u low -i video-display "Display Configured" "Extended <b>${mon_name}</b> above primary"
            ;;
        *"Mirror"*)
            PRIMARY_MON=$(hyprctl monitors -j 2>/dev/null | jq -r '.[0].name // "eDP-1"')
            hyprctl keyword monitor "${mon_name},preferred,auto,1,mirror,${PRIMARY_MON}"
            notify-send -u low -i video-display "Display Configured" "Mirrored <b>${mon_name}</b> with ${PRIMARY_MON}"
            ;;
        *"External Display Only"*)
            INTERNAL_MON=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.name | test("eDP|LVDS")) | .name' | head -n 1)
            [ -n "$INTERNAL_MON" ] && hyprctl keyword monitor "${INTERNAL_MON},disable"
            hyprctl keyword monitor "${mon_name},preferred,auto,1"
            notify-send -u low -i video-display "Display Configured" "Disabled internal screen. Using <b>${mon_name}</b> only."
            ;;
        *)
            # Ignore / do nothing
            ;;
    esac
}

handle_monitor_removed() {
    local mon_name="$1"
    notify-send -u low -i video-display-disconnected \
        "Display Disconnected" "Monitor <b>${mon_name}</b> disconnected. Restoring default layout."
    
    # Re-enable any disabled internal displays
    hyprctl keyword monitor "eDP-1,preferred,auto,1" 2>/dev/null || true
}

# Main Event Loop
SOC_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

if command -v socat >/dev/null 2>&1 && [ -S "$SOC_PATH" ]; then
    socat -U - UNIX-CONNECT:"$SOC_PATH" | while read -r line; do
        if [[ "$line" =~ ^monitoradded\>\>(.*) ]]; then
            MON="${BASH_REMATCH[1]}"
            handle_monitor_added "$MON"
        elif [[ "$line" =~ ^monitorremoved\>\>(.*) ]]; then
            MON="${BASH_REMATCH[1]}"
            handle_monitor_removed "$MON"
        fi
    done
else
    # Fallback polling loop
    PREV_MONITORS=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' | sort | tr '\n' ' ')
    while true; do
        CURRENT_MONITORS=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' | sort | tr '\n' ' ')
        if [ "$CURRENT_MONITORS" != "$PREV_MONITORS" ] && [ -n "$PREV_MONITORS" ]; then
            # Find added monitor
            for mon in $CURRENT_MONITORS; do
                if ! echo "$PREV_MONITORS" | grep -qw "$mon"; then
                    handle_monitor_added "$mon"
                fi
            done
            # Find removed monitor
            for mon in $PREV_MONITORS; do
                if ! echo "$CURRENT_MONITORS" | grep -qw "$mon"; then
                    handle_monitor_removed "$mon"
                fi
            done
        fi
        PREV_MONITORS="$CURRENT_MONITORS"
        sleep 3
    done
fi
