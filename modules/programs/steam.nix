{username, ...}:
{pkgs, lib, ...}:
{
    users.users.${username}.packages = with pkgs; [steam];

    # Steam is 32 bit
    hardware.opengl.driSupport32Bit = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
    ];
}
