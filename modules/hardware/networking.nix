{hostname, ...}:
{pkgs, ...}:
{
    networking.hostName = hostname;
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [
        5173 # Svelte apps - for debugging
    ];
    networking.firewall.allowedUDPPorts = [];

    # Despite it's name - this is not a tray applet. 
    # this is for nm-connection-editor
    programs.nm-applet = {
        enable = true;
    };
}
