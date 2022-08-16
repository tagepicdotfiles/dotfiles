with import <nixpkgs> {};

pkgs.discord.override {
    nss_latest = pkgs.nss_3_81;
}
