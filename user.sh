#!/bin/bash
cd ~
cp -R /temp/home/davk/.config /home/davk/
rm -rf /temp

git clone https://github.com/BosscastDavK/HyprV4.git
git clone https://github.com/Jguer/yay.git
cd ./yay
makepkg -si

echo "Done Logging DavK Out"
sleep 10
exit
