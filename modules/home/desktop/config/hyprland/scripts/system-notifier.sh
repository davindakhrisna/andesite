#!/usr/bin/env bash
# ==============================================================================
# Flint Desktop System Event Notifier
# Listens for Network, Bluetooth, and Battery/Power state changes
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. BATTERY & POWER MONITOR
# ------------------------------------------------------------------------------
battery_monitor() {
    BAT_DIR=$(find /sys/class/power_supply -name "BAT*" 2>/dev/null | head -n 1)

    [ -z "$BAT_DIR" ] && return 0

    PREV_STATUS=""
    WARNED_LOW=0
    WARNED_CRITICAL=0

    while true; do
        STATUS=$(cat "$BAT_DIR/status" 2>/dev/null || echo "Unknown")
        CAPACITY=$(cat "$BAT_DIR/capacity" 2>/dev/null || echo "100")

        # Detect State Changes (Plugged / Unplugged)
        if [ "$STATUS" != "$PREV_STATUS" ] && [ -n "$PREV_STATUS" ]; then
            if [ "$STATUS" = "Charging" ]; then
                notify-send -u normal -i battery-charging \
                    "🔌 Charger Connected" "Battery is charging at <b>${CAPACITY}%</b>"
                WARNED_LOW=0
                WARNED_CRITICAL=0
            elif [ "$STATUS" = "Discharging" ]; then
                notify-send -u normal -i battery \
                    "🔋 Charger Disconnected" "Running on battery: <b>${CAPACITY}%</b> remaining"
            elif [ "$STATUS" = "Full" ]; then
                notify-send -u low -i battery-full-charged \
                    "⚡ Battery Full" "Battery is fully charged (100%)"
            fi
        fi
        PREV_STATUS="$STATUS"

        # Low Battery Thresholds (Only when discharging)
        if [ "$STATUS" = "Discharging" ]; then
            if [ "$CAPACITY" -le 10 ] && [ "$WARNED_CRITICAL" -eq 0 ]; then
                notify-send -u critical -i battery-empty \
                    "🚨 Battery Critical (${CAPACITY}%)" "Battery is extremely low! Plug in charger immediately."
                WARNED_CRITICAL=1
                WARNED_LOW=1
            elif [ "$CAPACITY" -le 20 ] && [ "$WARNED_LOW" -eq 0 ]; then
                notify-send -u normal -i battery-caution \
                    "⚠️ Battery Low (${CAPACITY}%)" "Battery is running low. Please connect charger."
                WARNED_LOW=1
            fi
        fi

        # Reset warnings if capacity increases
        if [ "$CAPACITY" -gt 25 ]; then
            WARNED_LOW=0
            WARNED_CRITICAL=0
        fi

        sleep 10
    done
}

# ------------------------------------------------------------------------------
# 2. NETWORK & WIFI MONITOR
# ------------------------------------------------------------------------------
network_monitor() {
    PREV_STATE=""

    # Wait for desktop init
    sleep 3

    while true; do
        # Check active connection
        ACTIVE_CON=$(nmcli -t -f TYPE,STATE,CONNECTION dev 2>/dev/null | grep ':connected:' | head -n 1)

        if [ -n "$ACTIVE_CON" ]; then
            CON_TYPE=$(echo "$ACTIVE_CON" | cut -d: -f1)
            CON_NAME=$(echo "$ACTIVE_CON" | cut -d: -f3)
            CURRENT_STATE="connected:$CON_TYPE:$CON_NAME"

            if [ "$CURRENT_STATE" != "$PREV_STATE" ] && [ -n "$PREV_STATE" ]; then
                IP=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')
                [ -z "$IP" ] && IP="Acquiring IP..."

                if [ "$CON_TYPE" = "wifi" ] || [ "$CON_TYPE" = "802-11-wireless" ]; then
                    notify-send -u normal -i network-wireless \
                        "📶 WiFi Connected" "Connected to <b>${CON_NAME}</b>\nIP: ${IP}"
                else
                    notify-send -u normal -i network-wired \
                        "🌐 Ethernet Connected" "Connected to <b>${CON_NAME}</b>\nIP: ${IP}"
                fi
            fi
            PREV_STATE="$CURRENT_STATE"
        else
            CURRENT_STATE="disconnected"
            if [ "$CURRENT_STATE" != "$PREV_STATE" ] && [ -n "$PREV_STATE" ]; then
                notify-send -u low -i network-wireless-disconnected \
                    "⚠️ Network Disconnected" "Lost internet connection"
            fi
            PREV_STATE="$CURRENT_STATE"
        fi

        sleep 5
    done
}

# ------------------------------------------------------------------------------
# 3. BLUETOOTH MONITOR
# ------------------------------------------------------------------------------
bluetooth_monitor() {
    command -v bluetoothctl >/dev/null 2>&1 || return 0

    PREV_CONNECTED=""

    while true; do
        CURRENT_CONNECTED=$(bluetoothctl devices Connected 2>/dev/null | cut -d' ' -f3- | sort | tr '\n' ',' | sed 's/,$//')

        if [ "$CURRENT_CONNECTED" != "$PREV_CONNECTED" ] && [ -n "$PREV_CONNECTED" ]; then
            if [ -n "$CURRENT_CONNECTED" ]; then
                notify-send -u normal -i bluetooth \
                    "🎧 Bluetooth Connected" "Connected to <b>${CURRENT_CONNECTED}</b>"
            else
                notify-send -u low -i bluetooth-disabled \
                    "Bluetooth Disconnected" "Device disconnected"
            fi
        fi
        PREV_CONNECTED="$CURRENT_CONNECTED"
        sleep 5
    done
}

# ------------------------------------------------------------------------------
# Launch All Listeners
# ------------------------------------------------------------------------------
battery_monitor &
network_monitor &
bluetooth_monitor &

# Wait for all background loops
wait
