#! /bin/sh

chsh -s /bin/zsh

ls -sf /usr/share/zoneinfo/America/Bogota /etc/localtime

sed -i "s/#en_US.UTF-8\ UTF-8/en_US.UTF-8\ UTF-8/" /etc/locale.gen
sed -i "s/#en_US\ ISO-8859-1/en_US\ ISO-8859-1/" /etc/locale.gen
sed -i "s/#es_CO.UTF-8\ UTF-8/es_CO.UTF-8\ UTF-8/" /etc/locale.gen
sed -i "s/#es_CO\ ISO-8859-1/es_CO\ ISO-8859-1/" /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=la-latin1 > /etc/vconsole.conf
echo Archlinux > /etc/hostname
echo 127.0.0.1\   localhost > /etc/hosts
echo ::1\         localhost >> /etc/hosts
echo 127.0.0.1    Archlinux.localdomain Archlinux >> /etc/hosts

systemctl enable NetworkManager

passwd

reflector --verbose --country Colombia --country 'United States' --protocol https --protocol http --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

pacman -Sy grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

exit
