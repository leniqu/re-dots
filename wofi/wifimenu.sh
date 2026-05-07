#!/usr/bin/env bash

# Получаем список сетей (фильтруем лишнее и берем только названия)
#notify-send "Поиск сетей..."
LIST=$(nmcli --terse --fields SSID device wifi list | grep -v '^--' | sort -u)

# Запускаем wofi без поиска
CHOSEN=$(echo -e "$LIST" | wofi -d -c ~/.config/wofi/config_wifi -s ~/.config/wofi/style_wifi -p "WiFi")

# Если что-то выбрали — подключаемся
if [ -n "$CHOSEN" ]; then
    # Проверяем, нужен ли пароль (известная сеть или нет)
    if nmcli -t -f NAME connection show | grep -q "^$CHOSEN$"; then
        nmcli device wifi connect "$CHOSEN"
    else
        # Запрашиваем пароль через wofi, если сеть новая
        PASSWORD=$(wofi -d -p "Пароль для $CHOSEN:" -L 1)
        if [ -n "$PASSWORD" ]; then
            nmcli device wifi connect "$CHOSEN" password "$PASSWORD"
        fi
    fi
fi
