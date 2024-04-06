#!/bin/bash

mount -o subvol=@ /dev/nvme0n1p5 /mnt
rm -rf /mnt/*
echo "/ Mounted and Reset"

mkdir /mnt/home
mount -o subvol=@home /dev/nvme0n1p5 /mnt/home
rm -rf /mnt/home/*
echo "/home Mounted and Reset"

mkdir /mnt/mnt
mkdir /mnt/mnt/defvol
mount -o subvol=/ /dev/nvme0n1p5 /mnt/mnt/defvol
echo "defvol Mounted"

mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p2 /mnt/boot/efi
echo "EFI Mounted"

mkdir /mnt/games
mount /dev/sda2 /mnt/games
echo "Games Mounted"

mkdir /mnt/storagedrive
mount /dev/sdb2 /mnt/storagedrive
echo "Storage Drive Mounted"

mkdir /mnt/software
mount /dev/nvme1n1p2 /mnt/software
echo "Software Mounted"

swapon /dev/nvme0n1p6
echo "SWAPON"

pacstrap -K /mnt base linux linux-firmware amd-ucode base-devel bash-completion btrfs-progs git wget nano ntfs-3g sudo openssh pacman-contrib

echo "Copying files to /temp"
cp -R . /mnt/temp

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /temp/root.sh

umount -R /mnt

echo "Rebooting in 10 seconds"
sleep 10
reboot
