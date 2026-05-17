#!/usr/bin/env bash
# Открываем/закрываем плеер по клику
if eww active-windows | grep -q "player"; then
    eww close player
else
    ~/.config/eww/cover.sh
    eww open player
fi
