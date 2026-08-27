#!/usr/bin/env bash

host=$(hostname)

# Options
lock="[1] Lock"
logout="[2] Logout"
saver="[3] Screen Saver"
hibernate="[4] Hibernate"
shutdown="[5] Shutdown"
reboot="[6] Reboot"

options="$lock\n$logout\n$saver\n$hibernate\n$shutdown\n$reboot"

chosen=$(echo -e "$options" | rofi -dmenu \
    -p "SESSION MANAGER" \
    -mesg "Type number to select" \
    -theme-str '
    * {
        font: "Iosevka Nerd Font 12";
        background-color: transparent;
    }
    window {
        location: center;
        anchor: center;
        width: 200px;
        border: 2px solid;
        border-radius: 0px;
        padding: 0px;
    }
    mainbox {
        spacing: 0px;
        padding: 0px;
        children: [ inputbar, listview, message ];
    }
    inputbar {
        padding: 6px 28.8px;
        children: [ prompt ];
    }
    prompt {
        enabled: true;
        expand: true;
        font: "Iosevka Nerd Font Bold 13";
    }
    listview {
        lines: 6;
        fixed-height: true;
        scrollbar: false;
        spacing: 0px;
        padding: 0px;
        margin: 0px;
    }
    element {
        padding: 6px 12px;
        margin: 0px;
        border: 0px;
        border-radius: 0px;
        children: [ element-text ];
    }
    message {
        padding: 6px;
        border: 2px 0px 0px 0px;
    }
    textbox {
        expand: true;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        font: "Iosevka Nerd Font 10.5";
    }
    ')

case "$chosen" in
    "$lock")
        hyprlock
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
    "$saver")
        "${0%/*}/screensaver.sh" start
        ;;
    "$hibernate")
        systemctl hibernate
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
esac
