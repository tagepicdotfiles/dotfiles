{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.caddy = {
        enable = true;

        virtualHosts."vail-scraper.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.vailScraper.scraper}
        '';
        virtualHosts."grafana.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.utils.grafana}
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
