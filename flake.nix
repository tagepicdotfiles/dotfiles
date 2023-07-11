{
    description = "dotfiles";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
                flake-utils.follows = "flake-utils";
                flake-compat.follows = "flake-compat";
                nixpkgs.follows = "nixpkgs";
                rust-overlay.follows = "rust-overlay";
            };
        };


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
        btop-gpu = {
            url = "github:tag-epic/btop-gpu-flake";
            inputs = {
                # TODO: Uncomment once the stable version of "fmt" is 10.0.0
                #nixpkgs.follows = "nixpkgs";
                flake-utils.follows = "flake-utils";
                nixpkgs.follows = "nixpkgs-unstable";
            };
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations.kraken = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [home-manager.nixosModules.default (import ./machines/kraken/configuration.nix inputs)];
        };
        nixosConfigurations.sylveon = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [home-manager.nixosModules.default (import ./machines/sylveon/configuration.nix inputs)];
        };
    };
}
