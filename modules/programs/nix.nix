{username, inputs, ...}:
{...}:
{
    nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = ["nixpkgs=flake:nixpkgs"];
        settings = {
            auto-optimise-store = true;
            experimental-features = [ "nix-command" "flakes" ];
        };
    };
    home-manager.users.${username} = {
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH\}";
    };
}
