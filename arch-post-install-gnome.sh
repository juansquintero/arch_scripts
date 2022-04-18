#! /bin/sh

useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/zsh juansquintero
passwd juansquintero
sed -i "s/#\ %wheel\ ALL=(ALL:ALL)\ ALL/%wheel\ ALL=(ALL:ALL)\ ALL/ " /etc/sudoers
pacman -S --noconfirm acpid ntp dbus cronie wget

systemctl enable acpid
systemctl enable ntpd

ntpd -gq
date
hwclock -w

# Xorg install
pacman -S --noconfirm xorg-server xorg-xinit xf86-video-amdgpu libinput amd-ucode android-udev pipewire-pulse wireplumber ttf-droid noto-fonts ttf-jetbrains-mono adobe-source-code-pro-fonts alacarte pipewire-jack ttf-fira-code

# Gnome install
pacman -S --noconfirm gnome-shell nautilus alacritty guake gnome-tweak-tool gnome-control-center xdg-user-dirs-gtk gdm gnome-keyring mutter cheese file-roller gedit gnome-calculator gnome-calendar gnome-clocks gnome-control-center gnome-disk-utility gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-system-monitor gnome-themes-extra

# Extra
pacman -S --noconfirm chromium btop 

# Alacrity setup 
sudo -u mkdir -p /home/juansquintero/.config/alacritty
sudo -u juansquintero wget -p /home/juansquintero/.config/alacritty https://raw.githubusercontent.com/juansquintero/arch_scripts/main/alacritty.yml

# yay install 
pacman -S --needed --noconfirm git base-devel
chmod 777 /yay-install.bash
sudo -u juansquintero /yay-install.bash
rm -rf /home/juansquintero/yay

sudo -u juansquintero yay -S pfetch-git --noconfirm
sudo -u juansquintero yay -S nerd-fonts-jetbrains-mono --noconfirm 


# Enable gnome lockscreen
systemctl enable gdm 


