#!/bin/bash
cp -R ./etc /etc

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

sudo su davk
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
yay -S linux-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git

git clone https://github.com/BosscasDavK/HyprV4.git

echo "Done Reboot"
