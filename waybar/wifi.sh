#!/usr/bin/env bash

# Получаем список сетей максимально быстро (без глубокого сканирования)
wifi_list=$(nmcli -t -f NAME connection show | grep -v '^lo' | sort)
# Если список пуст, просто выводим сообщение
if [ -z "$wifi_list" ]; then
    wifi_list="Сети не найдены"
fi

# Запускаем rofi
selected=$(echo -e "$wifi_list" | rofi -dmenu -i -p "Networks" -theme ~/.config/rofi/wifi.rasi)

# Если выбрали сеть и это не сообщение об ошибке
if [ -n "$selected" ] && [ "$selected" != "Сети не найдены" ]; then
    # Очищаем название сети от иконки
    ssid=$(echo "$selected" | sed 's/^    //' | xargs)
    nmcli device wifi connect "$ssid"
fi
