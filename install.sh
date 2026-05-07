#!/usr/bin/env bash
set -e

# 1. Определяем дистрибутив
if [ -f /etc/gentoo-release ]; then
    DISTRO="gentoo"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
else
    echo "❌ Ошибка: Этот скрипт поддерживает только Gentoo и Arch!"
    exit 1
fi

echo "✅ Определён дистрибутив: $DISTRO"

# 2. Проверка прав (не запускать от root)
if [ "$EUID" -eq 0 ]; then
    echo "❌ Ошибка: Не запускай этот скрипт от имени root (через sudo)!"
    exit 1
fi

# 3. Подготовка папок
BACKUP_DIR="$HOME/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
mkdir -p "$HOME/.config"

# 4. Функция для копирования с бэкапом
copy_with_backup() {
    local src=$1
    local dest=$2
    if [ -e "$dest" ]; then
        echo "📦 Бэкапим $(basename "$dest") в $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi
    cp -rf "$src" "$dest"
}

# 5. Установка зависимостей
if [ "$DISTRO" = "gentoo" ]; then
    echo "⚙️  Установка для Gentoo..."
    if ! command -v eselect-repository &>/dev/null; then
        sudo emerge --ask app-eselect/eselect-repository
    fi
    sudo eselect repository enable hyproverlay 2>/dev/null || true
    sudo emerge --sync
    sudo emerge --ask \
        gui-wm/hyprland gui-apps/waybar x11-misc/rofi gui-apps/wofi \
        app-misc/fastfetch x11-misc/dunst gui-apps/wlogout media-sound/cava \
        x11-misc/pywal x11-misc/nwg-look gui-libs/swaync media-video/playerctl \
        app-shells/zsh app-navigation/thunar
    
elif [ "$DISTRO" = "arch" ]; then
    echo "⚙️  Установка для Arch..."
    if ! command -v yay &>/dev/null; then
        echo "Installing yay..."
        sudo pacman -S --needed base-devel git
        git clone https://archlinux.org /tmp/yay
        cd /tmp/yay && makepkg -si && cd -
        rm -rf /tmp/yay
    fi
    # Используем yay для установки, так как некоторые пакеты (swaync, wlogout) в AUR
    yay -S --needed \
        hyprland waybar rofi kitty wofi fastfetch \
        dunst wlogout cava python-pywal nwg-look swaync \
        playerctl zsh thunar
fi

# 6. Копирование конфигов
echo "📂 Копируем конфиги..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Список папок для копирования
configs=("hypr" "waybar" "rofi" "kitty" "wofi" "fastfetch" "dunst" "wlogout" "swaync" "cava" "wal" "nwg-look")

for config in "${configs[@]}"; do
    if [ -d "$SCRIPT_DIR/$config" ]; then
        copy_with_backup "$SCRIPT_DIR/$config" "$HOME/.config/$config"
    fi
done

# Копируем .zshrc
if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    copy_with_backup "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
fi

echo -e "\n🎉 Готово! Перезайди в систему (или введи 'Hyprland')."
echo "📂 Все старые файлы сохранены здесь: $BACKUP_DIR"
