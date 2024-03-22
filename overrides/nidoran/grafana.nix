{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.prometheus = {
        enable = true;
        port = ports.utils.prometheus;

        scrapeConfigs = [
            {
                job_name = "vail-scraper";
                static_configs = [
                    {
                        targets = ["localhost:${toString ports.vailScraper.scraper}"];
                    }
                ];
            }
        ];
    };
    services.grafana = {
        enable = true;
        settings = {
            server = {
                http_port = ports.utils.grafana;
            };
        };
    };
}
