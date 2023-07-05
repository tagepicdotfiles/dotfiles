# Dotfiles
My current NixOS dotfiles

## Install
1. Install nixos normally
2. Download this repo
3. Copy your /etc/nixos/hardware-configuration.nix into <machine/hardware-configuration>
4. `sudo nixos-rebuild --flake .#<machineName>`
