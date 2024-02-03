{username, ...}:
{pkgs, lib, ...}:
{
    users.users.${username}.packages = with pkgs; [steam];

    # Steam is 32 bit
    hardware.opengl.driSupport32Bit = true;
}
