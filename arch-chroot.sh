#!/bin/bash

mkdir /mnt
mount -o subvol=@ /dev/nvme0n1p5 /mnt
mkdir /mnt/home
mount -o subvol=@home /dev/nvme0n1p5 /mnt/home
mkdir /mnt/mnt
mkdir /mnt/mnt/defvol
mount -o subvol=/ /dev/nvme0n1p5 /mnt/defvol
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p2 /mnt/boot/efi
mkdir /mnt/games
mount /dev/sda2 /mnt/games
mkdir /mnt/storagedrive
mount /dev/sdb2 /mnt/storagedrive
mkdir /mnt/software
mount /dev/nvme1n1p2 /mnt/software
swapon /dev/nvme0n1p6

pacstrap -K /mnt amd-ucode base base-devel btrfs-progs git linux linux-firmware nano sudo

cp -R root /mnt

arch-chroot /mnt
