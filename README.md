# re:dots

My personal Hyprland dotfiles with auto-generated colors via **Pywal**.  
Supports **Gentoo** and **Arch Linux**.

## 📸 Preview
https://github.com/user-attachments/assets/eccbb513-660d-4851-a6cc-1e7a0ac377b2


## 🚀 Stack
- **WM:** [Hyprland](https://hyprland.org) (Wayland)
- **Bar:** Waybar (Wi-Fi, volume, media player)
- **Launcher:** Rofi / Wofi
- **Terminal:** Kitty
- **Shell:** Zsh
- **Colors:** [Pywal](https://github.com/dylanaraps/pywal) (generates theme from wallpaper)
- **Visualizer:** Cava
- **Notifications:** SwayNC
- **Lock:** Hyprlock

## 📦 Installation

This repository features an **auto-installer** that detects your distribution and sets up everything automatically. It supports **Arch Linux** and **Gentoo**.

### Quick Start
```bash
git clone https://github.com/leniqu/re-dots.git
chmod +x install.sh
./install.sh
```

> [!IMPORTANT]
> - **Arch Users:** The script will install `yay` if it's not found to handle AUR packages.
> - **Gentoo Users:** Make sure you have your overlays synced and basic Wayland/Hyprland dependencies in `@world`.
> - **Backup:** The script automatically creates a backup of your old configs in `~/backup_TIMESTAMP`.

---


The script automatically detects your distribution (Gentoo or Arch) and installs all needed packages.



## 📜 License
MIT
