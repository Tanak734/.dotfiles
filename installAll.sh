#!/bin/bash

PACKAGES=(
  waybar kitty rofi swww neovim zsh stow git ttf-jetbrains-mono-nerd openrgb bluetui btop alacritty coolercontrol cups evdi-dkms displaylink gamemode gamescope keyd impala inter-font ttf-fira-code ttf-ubuntu-font-family nwg-bar sioyek protonplus tlp tlpui keyd
)

echo "Iniciando a instalação dos pacotes..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo "Instalação concluída! Reinicie o sistema."
