#!/bin/bash
set -e

error_handler() {
  echo "Ocorreu um erro na linha $1, código de retorno $2"
  exit $2
}

trap 'error_handler ${LINENO} $?' ERR

pacman-key --init && pacman-key --populate && pacman -Sy archlinux-keyring && pacman -Su

sudo pacman -S --needed git base-devel wget base-devel curl rust neofetch zsh && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
 
sudo yay -Y --gendb && yay -Syu --devel && yay -Y --devel --save

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k && echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si

source /opt/asdf-vm/asdf.fish
