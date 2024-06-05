{hostname, ...}:
{pkgs, ...}:
{
    networking.hostName = hostname;
    networking.networkmanager.enable = true;

    # Despite it's name - this is not a tray applet. 
    # this is for nm-connection-editor
    programs.nm-applet = {
        enable = true;
    };
}
