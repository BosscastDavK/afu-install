#!/bin/bash

cp -R afu /mnt

mount -o subvol=@home /dev/nvme0n1p5 /mnt/home
mount -o subvol=@ /dev/nvme0n1p5 /mnt
mount -o subvol=/ /dev/nvme0n1p5 /mnt/mnt/defvol
mount /dev/nvme0n1p2 /mnt/boot/efi
mount /dev/sda2 /mnt/games
mount /dev/sdb2 /mnt/storagedrive
mount /dev/nvme1n1p2 /mnt/software
swapon /dev/nvme0n1p6

pacstrap -K /mnt base linux linux-firmware amd-ucode btrfs-progs git nano

arch-chroot /mnt
