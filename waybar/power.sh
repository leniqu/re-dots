#!/usr/bin/env bash

options="  Выключить\n  Перезагрузить\n󰗼  Выйти\n󰤄  Спать\n  Заблокировать"

chosen=$(echo -e "$options" | wofi --dmenu -i -p "Power Menu")

case "$chosen" in
    "  Выключить") systemctl poweroff ;;
    "  Перезагрузить") systemctl reboot ;;
    "󰗼  Выйти") pkill Hyprland ;;
    "󰤄  Спать") systemctl suspend ;;
    "  Заблокировать") loginctl lock-session ;;
esac
