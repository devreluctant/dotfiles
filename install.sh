#!/bin/bash

set -e  # Exit on error

echo "Installing packages..."

# Core packages
sudo pacman -S --needed hyprland waybar kitty wofi dunst \
    grim slurp wl-clipboard cliphist imv \
    thunar libnotify \
    ttf-jetbrains-mono-nerd papirus-icon-theme \
    pipewire wireplumber pavucontrol \
    network-manager-applet blueman \
    qt5ct qt6ct

# AUR packages (requires yay)
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

echo "Installing AUR packages..."
yay -S --needed where-is-my-sddm-theme-git \
    nordic-theme \
    hyprpaper

echo "Creating config directories..."
mkdir -p ~/.config/{hypr,waybar,kitty,wofi,dunst,gtk-3.0,uwsm}

echo "Copying configs..."
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp -r kitty/* ~/.config/kitty/
cp -r wofi/* ~/.config/wofi/
cp -r dunst/* ~/.config/dunst/
cp -r gtk-3.0/* ~/.config/gtk-3.0/
cp -r uwsm/* ~/.config/uwsm/

echo "Copying SDDM config..."
sudo cp sddm/sddm.conf /etc/sddm.conf

echo "Setting up icon cache..."
sudo gtk-update-icon-cache /usr/share/icons/Papirus-Dark

echo "Creating Pictures directory for wallpapers..."
mkdir -p ~/Pictures/Wallpapers

echo "Installation complete!"
echo "Don't forget to:"
echo "1. Add your wallpapers to ~/Pictures/Wallpapers/"
echo "2. Update hyprpaper.conf with your wallpaper paths"
echo "3. Log out and back in"
