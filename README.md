# Dotfiles
My current NixOS dotfiles

## Install
1. Mount main and boot parition to /mnt and /mnt/boot
2. `sudo nixos-generate-config --root /mnt`
3. `sudo wget https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/configuration.nix -o /mnt/nixos/configuration.nix`
4. `nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager`
5. `nix-channel --update`
6. `nixos-install --root /mnt`
7. `nixos-enter /mnt`
8. `nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager`
9. `nix-channel --update`
