# re:dots

My personal Hyprland dotfiles with auto-generated colors via **Pywal**.  
Supports **Gentoo** and **Arch Linux**.

## 📸 Preview

https://github.com/user-attachments/assets/836ea3c1-509f-45a2-be24-7995ec81d080





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
* **Status & UI:** `waybar`, `rofi-wayland`, `swaynotificationcenter`, `nwg-look`, `swayosd`
* **Terminal & Shell:** `kitty`, `zsh`
* **Theming engine:** `python-pywal`, `playerctl`
* **Visuals & Tools:** `cava`, `fastfetch`, `wlogout`, `swaybg`, `swaync`

**Additional components (optional but recommended):**
* **Game Mode:** `gamemode` (for `Super+G` toggle)
* **SDDM Theme:** `sddm`, `qt6-svg`, `qt6-virtualkeyboard`, `qt6-multimedia`
  ```bash
  git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM
  cd SilentSDDM/
  sudo cp -rf . /usr/share/sddm/themes/silent/
  sudo cp -r /usr/share/sddm/themes/silent/fonts/* /usr/share/fonts/
  ```
  Then enable it in `/etc/sddm.conf`:
  ```ini
  [Theme]
  Current=silent
  ```

### 3. Deploy Configurations
Copy the configuration folders to your local `.config` directory. 
> [!WARNING]
> This will overwrite existing files. It is recommended to back up your current configs first.

```bash
# Create config directory if it doesn't exist
mkdir -p ~/.config

# Copy configuration folders
cp -r cava dunst fastfetch hypr kitty nwg-look rofi swaync swayosd wal waybar wlogout wofi ~/.config/

# Apply Zsh configuration
cp .zshrc ~/
```

### 4. Restart Hyprland
Log out and log back in for changes to take effect.






### 4. Final Setup
After copying the files, generate your color scheme using **Pywal** to match your wallpaper:
```bash
wal -i /path/to/your/wallpaper.jpg
```


The script automatically detects your distribution (Gentoo or Arch) and installs all needed packages.



## 📜 License
MIT
