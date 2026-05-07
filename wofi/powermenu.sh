#!/usr/bin/env bash

# Опции меню
# Символы подтянутся, если установлен любой Nerd Font
shutdown=" Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend=" Suspend"
logout=" Logout"

# Запуск wofi в режиме dmenu
selected=$(echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$logout" | wofi --show dmenu --style ~/.config/wofi/style.css --conf /dev/null --width 250 --lines 5 --cache-file /dev/null)

case $selected in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        hyprlock # или swaylock
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
