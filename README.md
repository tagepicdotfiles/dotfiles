# Dotfiles
My current NixOS dotfiles

## Install
1. Mount main and boot parition to /mnt and /mnt/boot
```sh
sudo nixos-generate-config --root /mnt
sudo wget https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/configuration.nix -o /mnt/nixos/configuration.nix

nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update

nixos-install --root /mnt

nixos-enter /mnt
nix-channel --add https://github.com/nix-community/home-manager/archive/master.zip home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
```
