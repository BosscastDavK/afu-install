#!/bin/bash
systemctl enable sshd
cd /temp
cp -R /temp/etc /

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

sed -e '/en_US.UTF-8/s/^#*//g' -i /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=us > /etc/vconsole.conf
echo AFU > /etc/hostname

pacman -Sy --noconfirm dhcpcd
systemctl enable dhcpcd@enp6s0
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

pacman -Sy --noconfirm linux-headers nvidia-dkms
mkinitcpio -P

pacman -Sy --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
cp /temp/etc/default/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "root password"
passwd
useradd -m -g users -G wheel,storage,games,power,lp -s /bin/bash davk
echo "user password"
passwd davk

echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
echo 'Defaults rootpw' | EDITOR='tee -a' visudo
#EDITOR=nano visudo

chown -R davk:users /temp
sudo su davk -c "/temp/user.sh"

echo "Done Exiting Chroot"
sleep 10
exit
