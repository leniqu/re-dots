#!/usr/bin/env bash
set -e

# Определяем дистрибутив
if [ -f /etc/gentoo-release ]; then
    DISTRO="gentoo"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
else
    echo "Этот скрипт только для Gentoo и Arch!"
    exit 1
fi

echo "Определён дистрибутив: $DISTRO"

# Проверка прав
if [ "$EUID" -eq 0 ]; then
    echo "Не запускай от root!"
    exit 1
fi

# Функция для копирования с бэкапом
copy_with_backup() {
    local src=$1
    local dest=$2
    if [ -e "$dest" ]; then
        echo "Бэкапим существующий $(basename "$dest") в $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR"
    fi
    cp -rf "$src" "$dest"
}

BACKUP_DIR="$HOME/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Установка зависимостей
if [ "$DISTRO" = "gentoo" ]; then
    echo "=== Установка для Gentoo ==="
    
    # Добавляем оверлеи
    if ! command -v layman &>/dev/null; then
        sudo emerge --ask eselect-repository
    fi
    
    sudo eselect repository enable hyproverlay 2>/dev/null || true
    sudo emerge --sync
    
    # Ставим пакеты
    sudo emerge --ask \
        hyprland waybar rofi kitty wofi fastfetch \
        dunst wlogout cava pywal nwg-look swaync \
        playerctl zsh thunar
    
elif [ "$DISTRO" = "arch" ]; then
    echo "=== Установка для Arch ==="
    
    # AUR helper
    if ! command -v yay &>/dev/null; then
        echo "Ставим yay..."
        sudo pacman -S --needed base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si
        rm -rf /tmp/yay
    fi
    
    # Ставим пакеты
    sudo pacman -S --needed \
        hyprland waybar rofi kitty wofi fastfetch \
        dunst wlogout cava python-pywal nwg-look swaync \
        playerctl zsh thunar
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Ставим Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Копируем конфиги
echo "Копируем конфиги..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_with_backup "$SCRIPT_DIR/hypr" "$HOME/.config/hypr"
copy_with_backup "$SCRIPT_DIR/waybar" "$HOME/.config/waybar"
copy_with_backup "$SCRIPT_DIR/rofi" "$HOME/.config/rofi"
copy_with_backup "$SCRIPT_DIR/kitty" "$HOME/.config/kitty"
copy_with_backup "$SCRIPT_DIR/wofi" "$HOME/.config/wofi"
copy_with_backup "$SCRIPT_DIR/fastfetch" "$HOME/.config/fastfetch"
copy_with_backup "$SCRIPT_DIR/dunst" "$HOME/.config/dunst"
copy_with_backup "$SCRIPT_DIR/wlogout" "$HOME/.config/wlogout"
copy_with_backup "$SCRIPT_DIR/swaync" "$HOME/.config/swaync"
copy_with_backup "$SCRIPT_DIR/cava" "$HOME/.config/cava"
copy_with_backup "$SCRIPT_DIR/wal" "$HOME/.config/wal"
copy_with_backup "$SCRIPT_DIR/nwg-look" "$HOME/.config/nwg-look"
copy_with_backup "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

echo ""
echo "Готово! Перезайди в систему, и Hyprland будет настроен."
echo "Бэкап старых конфигов: $BACKUP_DIR"
