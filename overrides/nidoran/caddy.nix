{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.caddy = {
        enable = true;
        virtualHosts."data-robbery.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.data-robbery.http}
        '';
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
