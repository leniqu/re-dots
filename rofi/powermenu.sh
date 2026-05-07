#!/usr/bin/env bash

# Оставляем только иконки
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

selected=$(echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$logout" | rofi -dmenu -theme ~/.config/rofi/powermenu.rasi)

case $selected in
    "$shutdown") systemctl poweroff ;;
    "$reboot") systemctl reboot ;;
    "$lock") hyprlock ;;
    "$suspend") systemctl suspend ;;
    "$logout") hyprctl dispatch exit ;;
esac
