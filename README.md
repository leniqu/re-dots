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
cd re-dots
chmod +x install.sh
./install.sh
```

> [!IMPORTANT]
> - **Arch Users:** The script will install `yay` if it's not found to handle AUR packages.
> - **Gentoo Users:** Make sure you have your overlays synced and basic Wayland/Hyprland dependencies in `@world`.
> - **Backup:** The script automatically creates a backup of your old configs in `~/backup_TIMESTAMP`.

---
## 🛠 Manual Installation

If you prefer to set everything up yourself or use a different distribution, follow these steps to get **re-dots** running on your system.

### 1. Clone the repository
First, grab the configuration files and enter the directory:
```bash
git clone https://github.com/leniqu/re-dots.git
cd re-dots
```

### 2. Install Dependencies
Make sure you have the necessary components installed via your package manager:
* **Window Manager:** `hyprland`, `hyprlock`, `hypridle`
* **Status & UI:** `waybar`, `rofi-wayland`, `swaynotificationcenter`, `nwg-look`
* **Terminal & Shell:** `kitty`, `zsh`
* **Theming engine:** `python-pywal`
* **Visuals & Tools:** `cava`, `fastfetch`, `wlogout`

### 3. Deploy Configurations
Copy the configuration folders to your local `.config` directory. 
> [!WARNING]
> This will overwrite existing files. It is recommended to back up your current configs first.

```bash
# Create config directory if it doesn't exist
mkdir -p ~/.config

# Copy configuration folders
cp -r cava dunst fastfetch hypr kitty nwg-look rofi swaync wal waybar wlogout wofi ~/.config/

# Apply Zsh configuration
cp .zshrc ~/
```

### 4. Final Setup
After copying the files, generate your color scheme using **Pywal** to match your wallpaper:
```bash
wal -i /path/to/your/wallpaper.jpg
```


The script automatically detects your distribution (Gentoo or Arch) and installs all needed packages.



## 📜 License
MIT
