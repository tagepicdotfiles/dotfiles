{ 
    description = "dotfiles";
    inputs = {
        # Libraries
        flake-utils.url = "github:numtide/flake-utils";
        flake-compat = {
            url = "github:edolstra/flake-compat";
            flake = false;
        };
        rust-overlay = {
            url = "github:oxalica/rust-overlay";
            inputs = {
                flake-utils.follows = "flake-utils";
                nixpkgs.follows = "nixpkgs";
            };
        };
        crane = {
            url = "github:ipetkov/crane";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };

        # Apps
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };
        wallpaper-collection = {
            url = "github:DenverCoder1/minimalistic-wallpaper-collection/main";
            flake = false;
        };
        hyprsome = {
            url = "github:sopa0/hyprsome";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-utils.follows = "flake-utils";
                crane.follows = "crane";
            };
        };
    };
    outputs = { nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations = {
            kraken = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = let
                    moduleParams = {
                        username = "epic";
                        hostname = "kraken";
                        system = "x86_64-linux";
                        inherit inputs;
                    };
                in [
                    # Dependencies
                    home-manager.nixosModules.default

                    # Overrides
                    (import ./overrides/kraken/hardware.nix inputs) 
                    (import ./overrides/kraken/debug-ports.nix inputs) 
                    
                    # Base modules
                    (import ./modules/base.nix moduleParams)
                    (import ./modules/home-manager.nix moduleParams)
                    (import ./modules/locale/nb-no.nix moduleParams)
                    (import ./modules/nix-ld.nix moduleParams)

                    # Hardware modules
                    (import ./modules/hardware/bootloader/systemd-boot.nix moduleParams)
                    (import ./modules/hardware/bluetooth.nix moduleParams)
                    (import ./modules/hardware/networking.nix moduleParams)
                    (import ./modules/hardware/audio.nix moduleParams)
                    (import ./modules/hardware/printing.nix moduleParams)

                    # Desktop modules
                    (import ./modules/programs/hyprland/module.nix moduleParams)
                    (import ./modules/programs/lightdm.nix moduleParams)


                    # Program modules
                    (import ./modules/programs/firefox.nix moduleParams)
                    (import ./modules/programs/discord.nix moduleParams)
                    (import ./modules/programs/signal.nix moduleParams)
                    (import ./modules/programs/alacritty/module.nix moduleParams)
                    (import ./modules/programs/steam.nix moduleParams)
                    (import ./modules/programs/office.nix moduleParams)

                    # CLI modules
                    (import ./modules/programs/cli-tools.nix moduleParams)
                    (import ./modules/programs/zoxide.nix moduleParams)
                    (import ./modules/programs/zsh/module.nix moduleParams)
                    (import ./modules/programs/neovim/module.nix moduleParams)
                    (import ./modules/programs/docker.nix moduleParams)
                    (import ./modules/programs/git.nix moduleParams)
                    (import ./modules/programs/nix.nix moduleParams)
                    (import ./modules/programs/waypipe.nix moduleParams)
                    (import ./modules/programs/sudo.nix moduleParams)

                    # Languages
                    (import ./modules/languages/rust.nix moduleParams)
                    (import ./modules/languages/c.nix moduleParams)
                    (import ./modules/languages/python.nix moduleParams)
                ];
            };
            sylveon = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = let
                    moduleParams = {
                        username = "epic";
                        hostname = "sylveon";
                        system = "x86_64-linux";
                        inherit inputs;
                    };
                in [
                    # Dependencies
                    home-manager.nixosModules.default

                    # Overrides
                    (import ./overrides/sylveon/hardware.nix inputs) 
                    (import ./overrides/sylveon/wrong-bootloader-path.nix moduleParams) 
                    (import ./overrides/sylveon/hyprland-remote-host/module.nix moduleParams)
                    (import ./overrides/sylveon/printing-server.nix moduleParams)
                    
                    # Base modules
                    (import ./modules/base.nix moduleParams)
                    (import ./modules/home-manager.nix moduleParams)
                    (import ./modules/locale/nb-no.nix moduleParams)

                    # Service modules
                    (import ./modules/ssh-server.nix moduleParams)

                    # Hardware modules
                    (import ./modules/hardware/bootloader/systemd-boot.nix moduleParams)
                    (import ./modules/hardware/networking.nix moduleParams)
                    (import ./modules/hardware/audio.nix moduleParams)
                    (import ./modules/hardware/graphics.nix moduleParams)
                    (import ./modules/hardware/printing.nix moduleParams)

                    # Program modules
                    (import ./modules/programs/alacritty/module.nix moduleParams)
                    (import ./modules/programs/steam.nix moduleParams)

                    # CLI modules
                    (import ./modules/programs/cli-tools.nix moduleParams)
                    (import ./modules/programs/zoxide.nix moduleParams)
                    (import ./modules/programs/zsh/module.nix moduleParams)
                    (import ./modules/programs/neovim/module.nix moduleParams)
                    (import ./modules/programs/docker.nix moduleParams)
                    (import ./modules/programs/git.nix moduleParams)
                    (import ./modules/programs/nix.nix moduleParams)
                    (import ./modules/programs/waypipe.nix moduleParams)
                    (import ./modules/programs/sudo.nix moduleParams)
                ];
            };
            nidoran = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = let
                    moduleParams = {
                        username = "epic";
                        hostname = "nidoran";
                        system = "x86_64-linux";
                        inherit inputs;
                    };
                in [
                    # Dependencies
                    home-manager.nixosModules.default

                    # Overrides
                    (import ./overrides/nidoran/hardware.nix inputs)
                    (import ./overrides/nidoran/caddy.nix inputs)
                    (import ./overrides/nidoran/grafana.nix inputs)
                    (import ./overrides/nidoran/networking.nix inputs)
                    
                    # Base modules
                    (import ./modules/base.nix moduleParams)
                    (import ./modules/home-manager.nix moduleParams)
                    (import ./modules/locale/nb-no.nix moduleParams)

                    # Service modules
                    (import ./modules/ssh-server.nix moduleParams)

                    # Hardware modules
                    (import ./modules/hardware/bootloader/grub.nix moduleParams)
                    (import ./modules/hardware/networking.nix moduleParams)

                    # CLI modules
                    (import ./modules/programs/cli-tools.nix moduleParams)
                    (import ./modules/programs/zoxide.nix moduleParams)
                    (import ./modules/programs/zsh/module.nix moduleParams)
                    (import ./modules/programs/neovim/module.nix moduleParams)
                    (import ./modules/programs/docker.nix moduleParams)
                    (import ./modules/programs/git.nix moduleParams)
                    (import ./modules/programs/nix.nix moduleParams)
                    (import ./modules/programs/sudo.nix moduleParams)
                ];
            };
        };
    };
}
