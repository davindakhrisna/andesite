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
    window {
        location: center;
        anchor: center;
        width: 240px;
        border: 2px solid;
        border-color: @border-col;
        border-radius: 0px;
        background-color: @background;
        padding: 0px;
    }
    mainbox {
        spacing: 0px;
        padding: 0px;
        children: [ inputbar, listview, message ];
    }
    inputbar {
        padding: 8px 12px;
        background-color: @background-alt;
        border: 0px 0px 1px 0px solid;
        border-color: @border-col;
        children: [ prompt ];
    }
    prompt {
        enabled: true;
        expand: true;
        font: "Iosevka Nerd Font Bold 12";
        text-color: @primary;
        horizontal-align: 0.5;
    }
    listview {
        lines: 6;
        fixed-height: true;
        scrollbar: false;
        spacing: 2px;
        padding: 6px;
        margin: 0px;
    }
    element {
        padding: 8px 12px;
        margin: 0px;
        border: 0px;
        border-radius: 0px;
        background-color: transparent;
        text-color: @foreground;
        children: [ element-text ];
    }
    element selected {
        background-color: @selected;
        text-color: @selected-fg;
    }
    message {
        padding: 6px;
        background-color: @background-alt;
        border: 1px 0px 0px 0px solid;
        border-color: @border-col;
    }
    textbox {
        expand: true;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        font: "Iosevka Nerd Font 10";
        text-color: @foreground;
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
