{...}: 
{pkgs, ...}: {
    services.printing = {
        enable = true;
        openFirewall = true;
        listenAddresses = ["*:631"];
    };
}
