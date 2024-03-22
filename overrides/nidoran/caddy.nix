{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.caddy = {
        enable = true;

        virtualHosts."vail-scraper.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.vailScraper.scraper}
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
