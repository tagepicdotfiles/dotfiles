{...}:
{...}: let
    ports = import ./ports.nix;
in {
    services.victoriametrics = {
        enable = true;
        retentionPeriod = 12; # 1 year
        listenAddress = ":${toString ports.utils.prometheus}";
        extraOptions = ["-promscrape.config=/etc/victoriametrics-scrape.yaml"];
    };
    environment.etc = {
        "victoriametrics-scrape.yaml" = ''
        # Sample config for Prometheus.
        global:
          scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
          evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
          # scrape_timeout is set to the global default (10s).

          # Attach these labels to any time series or alerts when communicating with
          # external systems (federation, remote storage, Alertmanager).
          #  external_labels:
          #    monitor: 'example'

        # Alertmanager configuration
        #alerting:
        #  alertmanagers:
        #  - static_configs:
        #    - targets: ['localhost:9093']

        # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
        #rule_files:
          # - "first_rules.yml"
          # - "second_rules.yml"

        # A scrape configuration containing exactly one endpoint to scrape:
        # Here it's Prometheus itself.
        scrape_configs:
          # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
          - job_name: 'vail-scraper'

            static_configs:
              - targets: [
                "localhost:${toString ports.vailScraper.scraper}" # filserver
              ]
        '';
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
