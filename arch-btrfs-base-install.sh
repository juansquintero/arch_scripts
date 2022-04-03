#! /bin/sh


# Btrfs definition and config

mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.btrfs -f /dev/nvme0n1p3

mount /dev/nvme0n1p3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@root
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@log 
btrfs su cr /mnt/@cache 
btrfs su cr /mnt/@tmp
btrfs su li /mnt

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

mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

reflector --verbose --country Colombia --country 'United States' --protocol http --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-lts linux-firmware neovim btrfs-progs zsh 

genfstab -U /mnt >> /mnt/etc/fstab 
cat /mnt/etc/fstab


