{username, ...}:
{pkgs, ...}: {
    # State
    system.stateVersion = "22.05";

    # User
    users.users.${username}.isNormalUser = true;

    # We can't avoid it
    nixpkgs.config.allowUnfree = true;
}
