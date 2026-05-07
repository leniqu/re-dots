#!/usr/bin/env bash

wallpapers=(
    "/путь/к/обоям/black.jpg"
    "/путь/к/обоям/white.jpg"
    "/путь/к/обоям/gray.jpg"
)

selected=$(printf "%s\n" "${wallpapers[@]}" | wofi --dmenu -i -p "Выбери обои")

if [ -n "$selected" ]; then
    sed -i "/^wallpaper = /c\wallpaper = ,$selected" ~/.config/hypr/hyprpaper.conf
    killall hyprpaper
    hyprpaper &
fi
