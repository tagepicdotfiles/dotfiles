{
    caddy = {
        http = 80;
        https = 443;
    };
    utils = {
        debugging = 8888;
        prometheus = 10000;
        grafana = 10001;
        plausible = 10007;
    };
    vailScraper = {
        scraper = 10002;
        questdb-web = 10003;
        questdb-postgres = 10005;
        ui = 10004;
        meilisearch = 10006;
        postgres = 10009;
    };
    blog = {
        blog = 10008;
    };
}
