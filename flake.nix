{
    description = "dotfiles";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";


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
            };
        };
        btop-gpu = {
            url = "github:tag-epic/btop-gpu-flake";
            inputs = {
                # TODO: Uncomment once the stable version of "fmt" is 10.0.0
                #nixpkgs.follows = "nixpkgs";
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
