#!/usr/bin/env bash
# ==============================================================================
# Ultra-Minimal Text OSD Handler (VOL: / BRG: / MIC:)
# ==============================================================================

ACTION="$1"

case "$ACTION" in
    "volume_up")
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
        if [[ "$vol_info" == *"[MUTED]"* ]]; then
            swayosd-client --custom-progress 0.0 --custom-progress-text "VOL: MUTED"
        else
            raw_vol=$(echo "$vol_info" | awk '{print $2}')
            pct=$(awk -v v="$raw_vol" 'BEGIN {printf "%d%%", v*100}')
            swayosd-client --custom-progress "$raw_vol" --custom-progress-text "VOL: $pct"
        fi
        ;;
    "volume_down")
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
        vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
        if [[ "$vol_info" == *"[MUTED]"* ]]; then
            swayosd-client --custom-progress 0.0 --custom-progress-text "VOL: MUTED"
        else
            raw_vol=$(echo "$vol_info" | awk '{print $2}')
            pct=$(awk -v v="$raw_vol" 'BEGIN {printf "%d%%", v*100}')
            swayosd-client --custom-progress "$raw_vol" --custom-progress-text "VOL: $pct"
        fi
        ;;
    "volume_mute")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
        if [[ "$vol_info" == *"[MUTED]"* ]]; then
            swayosd-client --custom-progress 0.0 --custom-progress-text "VOL: MUTED"
        else
            raw_vol=$(echo "$vol_info" | awk '{print $2}')
            pct=$(awk -v v="$raw_vol" 'BEGIN {printf "%d%%", v*100}')
            swayosd-client --custom-progress "$raw_vol" --custom-progress-text "VOL: $pct"
        fi
        ;;
    "mic_mute")
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        mic_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
        if [[ "$mic_info" == *"[MUTED]"* ]]; then
            swayosd-client --custom-progress 0.0 --custom-progress-text "MIC: MUTED"
        else
            swayosd-client --custom-progress 1.0 --custom-progress-text "MIC: ON"
        fi
        ;;
    "brightness_up")
        brightnessctl set 5%+ -q 2>/dev/null
        curr=$(brightnessctl get 2>/dev/null || echo 100)
        max=$(brightnessctl max 2>/dev/null || echo 100)
        pct=$(( curr * 100 / max ))
        prog=$(awk -v c="$curr" -v m="$max" 'BEGIN {printf "%.2f", c/m}')
        swayosd-client --custom-progress "$prog" --custom-progress-text "BRG: ${pct}%"
        ;;
    "brightness_down")
        brightnessctl set 5%- -q 2>/dev/null
        curr=$(brightnessctl get 2>/dev/null || echo 100)
        max=$(brightnessctl max 2>/dev/null || echo 100)
        pct=$(( curr * 100 / max ))
        prog=$(awk -v c="$curr" -v m="$max" 'BEGIN {printf "%.2f", c/m}')
        swayosd-client --custom-progress "$prog" --custom-progress-text "BRG: ${pct}%"
        ;;
esac
