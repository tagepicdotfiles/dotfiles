{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.caddy = {
        enable = true;

        virtualHosts."vail-scraper.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.vailScraper.scraper}
        '';
        virtualHosts."vail.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.vailScraper.ui}
        '';
        virtualHosts."grafana.farfrom.world".extraConfig = ''
            reverse_proxy http://localhost:${toString ports.utils.grafana}
        '';
    };
    networking.firewall.allowedTCPPorts = [
        80
        443

        ${ports.utils.debugging}
    ];
    networking.firewall.allowedUDPPorts = [
        80
        443

        ${ports.utils.debugging}
    ];

}
