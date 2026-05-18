#!/usr/bin/env bash
set -e

# Цвета для вывода в терминал
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Определяем дистрибутив
if [ -f /etc/gentoo-release ]; then
    DISTRO="gentoo"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
else
    echo -e "${RED}Ошибка: Этот скрипт поддерживает только Gentoo и Arch!${NC}"
    exit 1
fi

echo -e "${GREEN}📦 Определён дистрибутив: $DISTRO${NC}"

# 2. Проверка прав (не запускать от root)
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Ошибка: Не запускай этот скрипт от имени root (через sudo)!${NC}"
    exit 1
fi

# 3. Подготовка папок
BACKUP_DIR="$HOME/backup_$(date +%Y%m%d_%H%M%S)"
BACKUP_CREATED=false
mkdir -p "$HOME/.config"

# 4. Функция для копирования с бэкапом
copy_with_backup() {
    local src=$1
    local dest=$2
    if [ -e "$dest" ]; then
        if [ "$BACKUP_CREATED" = false ]; then
            mkdir -p "$BACKUP_DIR"
            BACKUP_CREATED=true
        fi
        echo -e "${YELLOW}💾 Бэкапим $(basename "$dest") в $BACKUP_DIR${NC}"
        mv "$dest" "$BACKUP_DIR/"
    fi
    cp -rf "$src" "$dest"
}

# Функция для настройки темы SDDM
install_sddm_theme() {
    echo -e "${BLUE}🎨 Устанавливаем SDDM тему SilentSDDM...${NC}"
    rm -rf /tmp/SilentSDDM
    git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM /tmp/SilentSDDM
    
    sudo mkdir -p /usr/share/sddm/themes/silent
    sudo cp -rf /tmp/SilentSDDM/. /usr/share/sddm/themes/silent/
    
    # Копируем шрифты и обновляем кэш
    if [ -d /tmp/SilentSDDM/fonts ]; then
        sudo mkdir -p /usr/share/fonts/TTF
        sudo cp -r /tmp/SilentSDDM/fonts/* /usr/share/fonts/TTF/
        echo "🔄 Обновляем кэш системных шрифтов..."
        sudo fc-cache -fv >/dev/null
    fi
    rm -rf /tmp/SilentSDDM

    # Надежная настройка темы в sddm.conf
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=silent" | sudo tee /etc/sddm.conf.d/theme.conf >/dev/null
    echo -e "${GREEN}✅ Тема SDDM успешно настроена!${NC}"
}

# 5. Установка зависимостей
if [ "$DISTRO" = "gentoo" ]; then
    echo -e "${BLUE}=== Установка для Gentoo ===${NC}"
    if ! command -v eselect &>/dev/null; then
        sudo emerge --ask=n app-eselect/eselect-repository
    fi
    sudo eselect repository enable hyproverlay 2>/dev/null || true
    sudo emaint sync -r hyproverlay
    
    # Исправленный список пакетов
    GENTOO_PKGS="gui-wm/hyprland gui-apps/waybar x11-misc/rofi gui-apps/wofi \
        x11-terms/kitty app-misc/fastfetch x11-misc/dunst gui-apps/wlogout \
        media-sound/cava x11-misc/nwg-look gui-apps/swaync gui-apps/swayosd \
        media-sound/playerctl app-shells/zsh xfce-base/thunar games-util/gamemode \
        gui-apps/eww x11-misc/sddm"

    sudo emerge --ask --changed-use --deep @world $GENTOO_PKGS
    install_sddm_theme

elif [ "$DISTRO" = "arch" ]; then
    echo -e "${BLUE}=== Установка для Arch ===${NC}"
    if ! command -v yay &>/dev/null; then
        echo -e "${YELLOW}Устанавливаем хелпер yay...${NC}"
        sudo pacman -S --needed --noconfirm base-devel git
        (cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm)
    fi
    
    # Для Арча оставляем как есть, там эти пакеты делятся без проблем
    ARCH_PKGS="hyprland waybar rofi-wayland wofi kitty fastfetch \
        dunst wlogout cava python-pywal nwg-look swaync swayosd \
        playerctl zsh thunar gamemode eww-wayland-bin sddm qt6-svg qt6-virtualkeyboard qt6-multimedia"

    yay -S --needed --noconfirm $ARCH_PKGS
    install_sddm_theme
fi

# 6. Копирование конфигов
echo -e "${BLUE}📂 Копируем конфиги окружения...${NC}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

configs=("hypr" "waybar" "rofi" "kitty" "wofi" "fastfetch" "dunst" "wlogout" "swaync" "cava" "wal" "nwg-look" "eww" "swayosd")

for config in "${configs[@]}"; do
    if [ -d "$SCRIPT_DIR/$config" ]; then
        copy_with_backup "$SCRIPT_DIR/$config" "$HOME/.config/$config"
        echo "  ✅ Конфиг $config скопирован"
    fi
done

# Копируем .zshrc
if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    copy_with_backup "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    echo "  ✅ Конфиг .zshrc скопирован"
fi

echo ""
echo -e "${GREEN}✨ Всё готово! Перезайди в систему (или введи 'Hyprland').${NC}"
if [ "$BACKUP_CREATED" = true ]; then
    echo -e "${YELLOW}📦 Старые файлы сохранены в: $BACKUP_DIR${NC}"
else
    echo "Бэкап не потребовался, старых конфигов не обнаружено."
fi
