{...}:
{pkgs, ...}:
{
    services.printing.enable = true;

    # Autodiscovery
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
}
