{...}:
{pkgs, ...}:
{
    services.xserver = {
        enable = true;
        libinput.enable = true;
        displayManager.lightdm = {
            enable = true;
            # TODO: Maybe add wallpaper
        };
    };
}
