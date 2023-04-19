!/bin/bash
set -e

error_handler() {
echo "An error occurred on line $1 with exit code $2"
exit $2
}
trap 'error_handler ${LINENO} $?' ERR

Update system
pacman-key --init
pacman-key --populate
pacman -Sy archlinux-keyring
pacman -Su
pacman -Syyu

##Install packages
sudo pacman -S firefox yakuake openssh qbittorrent k3b konsole alacritty dolphin ark kate neofetch git wget barrier packagekit-qt5

##Install yay
if sudo pacman -S --needed base-devel curl rust && cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd /home; then
sudo yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save
else
echo "Error installing yay. Skipping to next part."
fi

##Install asdf
if cd /tmp && git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si && cd /home; then
source /opt/asdf-vm/asdf.fish
else
echo "Error installing asdf. Skipping to next part."
fi

echo "Setup completed successfully."