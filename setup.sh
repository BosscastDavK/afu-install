#!/bin/bash
cp -R ./etc /
cp -R ./usr /

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

sed -e '/en_US.UTF-8/s/^#*//g' -i /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=us > /etc/vconsole.conf
echo AFU > /etc/hostname

pacman -Sy dhcpcd
systemctl enable dhcpcd@enp6s0
pacman -S networkmanager
systemctl enable NetworkManager

mkinitcpio -P

pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
cp ./etc/default/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

passwd
useradd -m -g users -G wheel,storage,games,power,lp -s /bin/bash davk
passwd davk

echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
echo 'Defaults rootpw' | EDITOR='tee -a' visudo
EDITOR=nano visudo

wget -P /opt/appimages/ -O cursor.AppImage https://download.cursor.sh/linux/appImage/x64

echo "Done Exiting"
sleep 10
exit
