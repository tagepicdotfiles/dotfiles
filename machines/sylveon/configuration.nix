# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}:
{ config, pkgs, ... }:
{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Bootloader.
    boot.loader = {
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot/efi";
    };
    hardware.opengl.enable = true;

    networking = {
        networkmanager.enable = true;
        hostName = "sylveon";
    };

    # Set your time zone.
    time.timeZone = "Europe/Oslo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.utf8";

    # Configure keymap in X11
    services.xserver = {
        layout = "no";
        xkbVariant = "";
    };
    # Configure console keymap
    console.keyMap = "no";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
        epic = {
            isNormalUser = true;
            description = "epic";
            extraGroups = [ "networkmanager" "wheel" "disk" "cdrom" "plugdev" "input"];
            packages = with pkgs; [
                waypipe
                steam
            ];
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        neovim
        makemkv
        handbrake
        btop
        python3
        libcdio # cd-info
        i2p
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    
    # List services that you want to enable:
    
    # Enable the OpenSSH daemon.
    services.openssh = {
        enable = true;
        forwardX11 = true;
    };
    services.jellyfin = {
        enable = true;
        openFirewall = true;
    };
    services.grafana = {
        enable = true;
        settings = {
        server.http_addr = "0.0.0.0";
        };
    };
    services.loki = {
        enable = true;
        configFile = "/etc/loki/config.yml";
    };
    services.promtail = {
        enable = true;
        configuration = {
        server.http_listen_port = 3003;
        client.url = "http://localhost:3001/api/prom/push";
        scrape_configs = [
            {
                job_name = "systemd";
                journal = {
                    max_age = "12h";
                    labels = {
                        job = "systemd-journal";
                    };
                };
            }
        ];
        };
    };
    services.prometheus = {
        enable = true;
        port = 3004;
        scrapeConfigs = [
        {
            job_name = "node_exporter";
            scrape_timeout = "20s";
            static_configs = [{
              targets = ["10.1.0.1:9100" "sylveon.home.arpa:9100"];
            }];
          }
        ];
        exporters = {
        node = {
            enable = true;
            enabledCollectors = [ "systemd" ];
            port = 9100;
        };
        };
    };
    
    virtualisation.docker = {
        enable = true;
    };
    
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [
        22 # SSH
        3000 # Grafana
        3001 # Grafana Loki
        3002 # Grafana Loki RPC
        3003 # Promtail HTTP
        3004 # Prometheus
        9090 # No clue
        9111 # No idea
        7657 # HUH?
        ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
    
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
    hardware.opengl.driSupport32Bit = true;
    
}
