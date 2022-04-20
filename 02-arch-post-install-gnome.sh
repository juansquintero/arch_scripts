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
pacman -S --noconfirm gnome-shell nautilus alacritty gnome-tweak-tool gnome-control-center xdg-user-dirs-gtk gdm gnome-keyring mutter cheese file-roller gedit gnome-calculator gnome-calendar gnome-clocks gnome-control-center gnome-disk-utility gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-system-monitor gnome-themes-extra

# Extra
pacman -S --noconfirm chromium btop 

# Alacrity setup 
mkdir -p /home/juansquintero/.config/alacritty
sudo -u juansquintero sudo cp /root/alacritty.yml /home/juansquintero/.config/alacritty/

# Ohmyzsh setup base
sudo -u juansquintero sudo mv /root/.zshrc /home/juansquintero/

# yay install 
pacman -S --needed --noconfirm git base-devel
chmod 777 yay-install.bash
sudo -u juansquintero sh ./yay-install.bash
rm -rf /home/juansquintero/yay

# yay package install

sudo -u juansquintero yay -S pfetch-git --noconfirm
sudo -u juansquintero yay -S nerd-fonts-jetbrains-mono --noconfirm 
sudo -u juansquintero yay -S touchegg 

# enable touchegg

systemctl enable touchegg.service

# setup touchegg

sudo -u juansquintero $ mkdir -p ~/.config/touchegg && cp -n /root/touchegg.conf ~/.config/touchegg/touchegg.conf



# flatpak install 
pacman -S flatpak --noconfirm

sudo -u juansquintero flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo -u juansquintero flatpak install -y flathub org.gnome.TextEditor
sudo -u juansquintero flatpak install -y flathub com.spotify.Client
sudo -u juansquintero flatpak install -y flathub com.discordapp.Discord
sudo -u juansquintero flatpak install -y flathub com.github.joseexposito.touche
sudo -u juansquintero flatpak install -y flathub com.mattjakeman.ExtensionManager


# Wallpaper
sudo -u juansquintero mkdir -p /home/juansquintero/Pictures/Wallpaper
sudo -u juansquintero cp -n /root/wall.png /home/juansquintero/Pictures/Wallpaper

# Enable gnome lockscreen
systemctl enable gdm 


