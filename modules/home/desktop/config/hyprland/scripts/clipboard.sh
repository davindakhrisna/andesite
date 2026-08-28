#!/usr/bin/env bash

# Export PATH with system and profile fallbacks
export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

# Ensure cliphist background watchers are running
if ! pgrep -fa "wl-paste.*cliphist store" > /dev/null; then
    wl-paste --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    sleep 0.1
fi

ACTION="${1:-select}"

case "$ACTION" in
    wipe|clear)
        cliphist wipe
        notify-send -a "Clipboard" "Clipboard Wiped" "History has been cleared" 2>/dev/null || true
        ;;
    select|*)
        # Transform binary data into explicit [IMAGE] label with details
        raw_list=$(cliphist list 2>/dev/null)
        [ -z "$raw_list" ] && { notify-send -a "Clipboard" "Clipboard is Empty" "No items in history" 2>/dev/null; exit 0; }

        formatted_list=$(echo "$raw_list" | sed -E 's/\t\[\[ binary data (.*) \]\]/\t🖼️  [IMAGE] \1/')

        selected=$(echo "$formatted_list" | rofi -dmenu \
            -p "Clipboard" \
            -mesg "Select to copy | Type to search | 'wipe' to clear" \
            -theme-str '
            window {
                location: center;
                anchor: center;
                width: 680px;
                border: 2px solid;
                border-color: @border-col;
                border-radius: 0px;
                background-color: @background;
                padding: 12px;
            }
            mainbox {
                spacing: 8px;
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
                placeholder: "Search clip history (text / images)...";
                placeholder-color: @border-col;
            }
            listview {
                lines: 8;
                columns: 1;
                fixed-height: false;
                scrollbar: false;
                spacing: 4px;
                padding: 4px 0px;
            }
            element {
                padding: 8px 12px;
                border-radius: 0px;
                background-color: transparent;
                text-color: @foreground;
            }
            element selected {
                background-color: @selected;
                text-color: @selected-fg;
            }
            element-text {
                text-color: inherit;
            }
            message {
                padding: 6px 12px;
                border: 1px solid;
                border-color: @border-col;
                border-radius: 0px;
                background-color: @background-alt;
            }
            textbox {
                horizontal-align: 0.5;
                font: "Iosevka Nerd Font 10";
                text-color: @foreground;
            }
            ')

        if [ -n "$selected" ]; then
            if [ "$selected" = "wipe" ]; then
                cliphist wipe
                notify-send -a "Clipboard" "Clipboard Wiped" "History has been cleared" 2>/dev/null || true
            else
                echo "$selected" | cliphist decode | wl-copy
                if [[ "$selected" == *"🖼️  [IMAGE]"* ]]; then
                    notify-send -a "Clipboard" -i image-x-generic "Image Copied" "Image binary loaded into clipboard" 2>/dev/null || true
                else
                    notify-send -a "Clipboard" -i edit-copy "Text Copied" "Copied to clipboard and ready to paste" 2>/dev/null || true
                fi
            fi
        fi
        ;;
esac
