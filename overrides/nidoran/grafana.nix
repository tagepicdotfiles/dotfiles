{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.prometheus = {
        enable = true;

        scrapeConfigs = [
            {
                job_name = "vail-scraper";
                static_configs = [
                    {
                        targets = ["http://localhost:${toString ports.vailScraper.scraper}"];
                    }
                ];
            }
        ];
    };
    services.grafana = {
        enable = true;
        settings = {};
    };
}
