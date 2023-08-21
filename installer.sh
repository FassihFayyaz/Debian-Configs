#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# Update packages list and update system
sudo apt update
sudo apt upgrade -y

# Install nala
apt install nala -y

# Fetch Latest/Fastest Mirrors
sudo nala fetch

# XFCE4 Minimal
# sudo nala install -y xfce4 xfce4-goodies

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Making .config and Moving config files and background to Pictures
sudo mkdir -p /home/$username/.config
sudo mkdir -p /home/$username/.fonts
sudo mkdir -p /home/$username/Pictures
sudo mkdir -p /home/$username/Pictures/backgrounds
cp wallpaper.png /home/$username/Pictures/backgrounds/
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install feh alacritty rofi picom thunar nitrogen lxpolkit x11-xserver-utils unzip wget pulseaudio xorg pavucontrol build-essential libx11-dev libxft-dev libxinerama-dev -y
# Installing Other less important Programs
nala install neofetch firefox-esr flameshot psmisc mangohud lxappearance papirus-icon-theme lxappearance fonts-noto-color-emoji lightdm -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
rm -rf Nordzy-cursors

# Install VSCode
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# Install Qtile
cd scripts
sh qtile-commands
cd ..

# copy my configuration files into the ~/.config directory
sudo cp -r dotconfig/* /home/$username/.config/

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"