#! /bin/sh

useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/zsh juansquintero
passwd juansquintero
sed -i "s/#\ %wheel\ ALL=(ALL:ALL)\ ALL/%wheel\ ALL=(ALL:ALL)\ ALL/ " /etc/sudoers
pacman -S acpid ntp dbus cronie 

systemctl enable acpid
systemctl enable ntpd

ntpd -gq
date
hwclock -w

# Xorg install
pacman -S xorg-server xorg-xinit xf86-video-amdgpu xf86-input-synaptics

# Gnome install
pacman -S gnome-shell nautilus gnome-terminal guake gnome-tweak-tool gnome-control-center xdg-user-dirs-gtk gdm gnome-keyring mutter cheese file-roller gedit gnome-calculator gnome-calendar gnome-clocks gnome-control-center gnome-disk-utility gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-system-monitor

# Extra
pacman -S chromium btop 

# yay install 
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si)

# Enable gnome lockscreen
systemctl enable gdm 
