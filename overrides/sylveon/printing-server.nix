{...}:
{pkgs, lib, ...}: {
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

    # Publishing
    services.avahi = {
        publish = {
            enable = true;
            userServices = true;
        };
    };
}
