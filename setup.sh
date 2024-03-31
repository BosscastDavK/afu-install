#!/bin/bash
cp -R ./etc /

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

locale-gen

mkinitcpio -P

pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

passwd
useradd -m -g users -G wheel,storage,games,power,lp -s /bin/bash davk
passwd davk

EDITOR=nano visudo

pacman -Sy dhcpcd
systemctl enable dhcpcd@enp6s0
pacman -S networkmanager
systemctl enable NetworkManager

cd ~
git clone https://aur.archlinux.org/yay.git /home/davk/yay
git clone https://github.com/BosscasDavK/HyprV4.git /home/davk/HyprV4
chown -R davk:users /home/davk/yay
chown -R davk:users /home/davk/HyprV4

sudo su davk

echo "Done Reboot"
