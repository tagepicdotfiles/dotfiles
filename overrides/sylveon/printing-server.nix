{username, ...}:
{pkgs, lib, ...}: {
    # Printing 
    services.printing = {
        openFirewall = true;
        listenAddresses = ["0.0.0.0:631"];
        allowFrom = [ "all" ];
        drivers = with pkgs; [
            cnijfilter2
        ];

        # Publishing
        browsing = true;
        defaultShared = true;
    };

    # Scanning
    hardware.sane = {
        enable = true;
    };
    services.ipp-usb.enable = true;
    users.users.${username}.extraGroups = ["scanner" "lp"];



    # Publishing
    services.avahi = {
        publish = {
            enable = true;
            userServices = true;
        };
    };
}
