#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Список файлов (только имена, без пути)
wallpapers=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) -exec basename {} \; | sort)

if [ -z "$wallpapers" ]; then
    notify-send "Ошибка" "Нет обоев в $WALLPAPER_DIR"
    exit 1
fi

selected=$(echo "$wallpapers" | rofi -dmenu -i -p "Выбери обои" -theme ~/.config/rofi/wallpaper.rasi)
if [ -n "$selected" ]; then
    full_path="$WALLPAPER_DIR/$selected"
    swww img "$full_path"
    wal -i "$full_path"
    killall waybar && waybar &
fi
