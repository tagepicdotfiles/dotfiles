{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.caddy = {
        enable = true;
    };
    networking.firewall.allowedTCPPorts = [
        80
        443
    ];
    networking.firewall.allowedUDPPorts = [
        80
        443
    ];

}
