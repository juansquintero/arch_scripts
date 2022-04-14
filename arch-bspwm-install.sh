#! /bin/sh

useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/zsh juansquintero
passwd juansquintero
sed -i "s/#\ %wheel\ ALL=(ALL:ALL)\ ALL/%wheel\ ALL=(ALL:ALL)\ ALL/ " /etc/sudoers
pacman -S --noconfirm acpid ntp dbus cronie 

systemctl enable acpid
systemctl enable ntpd

ntpd -gq
date
hwclock -w

# Xorg install
pacman -S --noconfirm xorg-server xorg-xinit xf86-video-amdgpu libinput amd-ucode android-udev pipewire-pulse wireplumber ttf-droid noto-fonts ttf-jetbrains-mono adobe-source-code-pro-fonts alacarte pipewire-jack

# Gnome install

pacman -S --noconfirm bspwm dmenu xdg-user-dirs sxhkd rofi alacritty

# Extra
pacman -S --noconfirm chromium btop 

# yay install 
pacman -S --needed --noconfirm git base-devel
chmod 777 /yay-install.bash
sudo -u juansquintero /yay-install.bash
rm -rf /home/juansquintero/yay

sudo -u juasnquintero sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u juansquintero yay -S pfetch-git --noconfirm
sudo -u juansquintero yay -S nerd-fonts-jetbrains-mono --noconfirm 
sudo -u juansquintero yay -S polybar --noconfirm 
sudo -u juansquintero yay -S lightdm betterlockscreen lightdm-webkit2-greeter --noconfirm 
# Enable gnome lockscreen


reboot
