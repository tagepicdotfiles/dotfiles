{username, inputs, ...}:
{...}:
{
    nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = [
            "nixpkgs=flake:nixpkgs"
            "nixpkgs-unstable=flake:nixpkgs-unstable"
        ];
        settings = {
            auto-optimise-store = true;
            experimental-features = [ "nix-command" "flakes" ];
        };
    };
    home-manager.users.${username} = {
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        nix.registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
        home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs:nixpkgs-unstable=flake:nixpkgs-unstable$\{NIX_PATH:+:$NIX_PATH\}";
    };
}
