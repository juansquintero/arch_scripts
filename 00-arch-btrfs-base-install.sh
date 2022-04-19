#! /bin/sh


# Btrfs definition and config

echo 'Setting up partitions a making file systems'

mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.btrfs -f /dev/nvme0n1p3

echo 'Setting up mount points'

mount /dev/nvme0n1p3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@root
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@log 
btrfs su cr /mnt/@cache 
btrfs su cr /mnt/@tmp
btrfs su li /mnt

echo 'Mounting optimized for btrfs'

cd /
umount /mnt
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@ /dev/nvme0n1p3 /mnt

mkdir -p /mnt/{home,root,srv,var/log,var/cache,tmp}

mount -o defaults,noatime,compress=zstd,commit=120,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@root /dev/nvme0n1p3 /mnt/root
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@srv /dev/nvme0n1p3 /mnt/srv
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@log /dev/nvme0n1p3 /mnt/var/log
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@cache /dev/nvme0n1p3 /mnt/var/cache
mount -o defaults,noatime,compress=zstd,commit=120,subvol=@tmp /dev/nvme0n1p3 /mnt/tmp

echo 'Mounting boot partitions'

mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

echo 'Setting up reflector and pacman parallel downloads'

reflector --verbose --country Colombia --country 'United States' --protocol http --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist

sed -i "s/#ParallelDownloads\ =\ 5/ParallelDownloads\ =\ 5/" /etc/pacman.conf

# Setup kernel select 
kernel_select() {
    kernel_list=(linux-lts linux)
    echo 'Seleccione el kernel'
    select kernel in "${kernel_list[@]}"; do
        if contains_element "${kernel}" "${kernel_list[@]}";then
            break
        else
            invalid_option
        fi
    done
    kernel_install = $kernel
}

echo 'Installing packages with packstrap'

pacstrap /mnt base base-devel $kernel_install linux-firmware reflector neovim btrfs-progs zsh git networkmanager

echo 'Generating fstab'

genfstab -U /mnt >> /mnt/etc/fstab 
cat /mnt/etc/fstab

echo 'Chrooting into install'

cp ~/arch_scripts/01-arch-chroot-config.sh /mnt/root
cp ~/arch_scripts/yay-install.bash /mnt/root
cp ~/arch_scripts/02-arch-post-install-gnome.sh /mnt/root
cp ~/arch_scripts/03-arch-bspwm-install.sh /mnt/root
cp ~/arch_scripts/alacritty.yml /mnt/root
cp ~/arch_scripts/.zshrc /mnt/root
cp ~/arch_scripts/touchegg.conf /mnt/root
cp ~/arch_scripts/wall.png /mnt/root

arch-chroot /mnt 



