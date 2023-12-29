{ self, wallpaper-collection, hyprsome, ...}:
{ config, pkgs, ... }:
let
  dotfiles = self + "/config";
  wallpaper = wallpaper-collection + "/images/daniel-ignacio-the-deer-spirit.jpg";
  animated-wallpaper = self + "/config/backgrounds/dots.mp4";
  system = "x86_64-linux";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kraken";

  # Networking
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall.allowedTCPPorts = [5173];
  networking.firewall.allowedUDPPorts = [];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
            inherit pkgs;
        };
    };
    permittedInsecurePackages = [
        "electron-24.8.6"
        "electron-25.9.0"
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "no";

  virtualisation.docker.enable = true;
  
  security.sudo.package = pkgs.sudo.override { withInsults = true; };

  services = {
    # WM
    openvpn.servers = {
        #htb = { config = '' config /etc/openvpn/htb.conf ''; };
    };
    xserver = {
      enable = true;
      layout = "no";
      libinput = {
        enable = true;
      };
      displayManager = {
        lightdm = {
          enable = true;
          background = wallpaper;
        };
      };
    };


    # Hardware
    printing.enable = true;
    pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
  };
  programs = {
    nm-applet.enable = true;
    zsh.enable = true;
    hyprland.enable = true;
    ssh = {
        startAgent = true;
    };
    noisetorch.enable = true;
  };
  #xdg.portal.wlr.enable = true;

  # Enable sound.
  #sound.enable = true;
  /* hardware.pulseaudio.enable = true; */
  hardware.bluetooth.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups = {
    wireshark = {};
  };
  users.users.epic = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" "docker" "tty" "dialout" ];
    packages = with pkgs; [
      #discord
      vesktop
      libreoffice
      #spotify
      keepassxc
      btop
      #btop-gpu.packages.${system}.default
      neofetch
      pfetch
      zoxide
      signal-desktop
      steam
      obsidian
      alacritty
      playerctl
      poetry
      nodePackages.pyright
      #brightnessctl
      prusa-slicer
      #cloc
      gh
      onefetch
      vscode
      ripgrep
      thunderbird
      arandr
      xonotic
      #thefuck
      bore-cli
      #blender
      obs-studio
      prismlauncher
      #comma
      rust-analyzer
      clippy
      insomnia
      #jdk17_headless # For vault hunters 1.18
      pyright
      nodejs
      nodePackages.pnpm
      gnumake
      cope
      jetbrains.idea-community
      gdb
      jq
      jless
      helvum
      easyeffects
      nodePackages.typescript-language-server
      nodePackages.svelte-language-server
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.epic = { pkgs, ...}: {
      manual.manpages.enable = false;
      home = {
        file = {
          ".config/oh-my-zsh/epic.zsh-theme".source = dotfiles + "/zsh/epic.zsh-theme";
          #".xbindkeysrc".source = dotfiles + "/xbindkeysrc";
          ".config/alacritty/alacritty.yml".source = dotfiles + "/alacritty/config.yml";

          # Polybar
          ".config/polybar/bar.sh".source = dotfiles + "/polybar/startbar.sh";
          ".config/polybar/polybar.ini".source = dotfiles + "/polybar/polybar.ini";
          ".config/polybar/scripts/get_volume.sh".source = dotfiles + "/polybar/scripts/get_volume.sh";

          # Hyprland
          ".config/hypr/hyprland.conf".source = dotfiles + "/hypr/hyprland.conf";
          ".config/hypr/hyprpaper.conf".text = ''
          preload = ${wallpaper}
          wallpaper = ,${wallpaper}
          '';
          #".config/hypr/hyprpaper.conf".source = dotfiles + "/hypr/hyprpaper.conf";
          #".config/hypr/wallpaper.jpg".source = wallpaper;
          ".config/hypr/animated-wallpaper.mp4".source = animated-wallpaper;

          # Waybar
          ".config/waybar/config".source = dotfiles + "/waybar/config.json";
          ".config/waybar/style.css".source = dotfiles + "/waybar/style.css";

          # NeoVIM
          #".config/nvim/init.vim".source = dotfiles + "/neovim.vim";
          #".local/share/nvim/site/autoload/plug.vim".source = builtins.fetchurl(
          #  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          #);
        };
        sessionVariables = {
          EDITOR = "nvim";
          TERM = "xterm-256color";
          PIP_DISABLE_PIP_VERSION_CHECK = "1";
          SSH_ASKPASS = ""; # Remove stupid credential popup
        };
        stateVersion = "22.05";
      };
      programs = {
        firefox = {
            enable = true;
            
            profiles.main = {
                isDefault = true;
                search = {
                    default = "Ecosia";
                    force = true;
                    engines = {
                        "Ecosia" = {
                            urls = [
                                {
                                    template = "https://www.ecosia.org/search";
                                    params = [
                                        {
                                            name = "method";
                                            value = "index";
                                        }
                                        {
                                            name = "q";
                                            value = "{searchTerms}";
                                        }
                                    ];
                                }
                            ];
                        };
                    };
                };
                settings = {
                    # Disable swipe navigation
                    "browser.gesture.swipe.left" = "";
                    "browser.gesture.swipe.right" = "";

                    # Disable zoom gesture
                    "browser.gesture.pinch.in" = "";
                    "browser.gesture.pinch.out" = "";

                    # Hide "Import bookmarks" button
                    "browser.bookmarks.addedImportButton" = false;

                    # Metrics
                    "toolkit.telemetry.enabled" = false;
                    "datareporting.policy.dataSubmissionEnabled" = false;
                    "datareporting.healthreport.service.enabled" = false;
                    "datareporting.healthreport.uploadEnabled" = false;
                };
                bookmarks = [
                    {
                        toolbar = true;
                        bookmarks = [
                            {
                                name = "Nixpkgs";
                                url = "https://search.nixos.org/packages";
                            }
                            {
                                name = "Home Manager";
                                url = "https://nix-community.github.io/home-manager/options.html";
                            }
                        ];
                    }
                ];
            };

            # Wayland. See firefox docs
            #package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            #    extraPolicies = {
            #        ExtensionSettings = {};
            #    };
            #};
        };
        git = {
          enable = true;
          userName = "TAG-Epic";
          userEmail = "tagepicuwu@gmail.com";
          delta.enable = true;
          ignores = [
            ".dev"
            "default.nix"
          ];
          extraConfig = {
            pull = {
              rebase = true;
            };
            push.autoSetupRemote = true;
            init.defaultBranch = "master";
            credential.helper = "store";
          };
        };

        zsh = {
          enable = true;
          oh-my-zsh = {
            enable = true;
            theme = "epic";
            plugins = ["git"];
            custom = "$HOME/.config/oh-my-zsh/";
          };
          shellAliases = {
            pushpwd = "scp ~/.config/keepassxc/Passwords.kdbx kratos.farfrom.world:~/Passwords.kdbx";
            pullpwd = "scp kratos.farfrom.world:~/Passwords.kdbx ~/.config/keepassxc/Passwords.kdbx";
            cd = "z";
            nix-view = "nix --experimental-features nix-command edit -f '<nixpkgs>'";
            dock = "xrandr --output eDP --off";
            undock = "xrandr --output eDP --auto";
          };
          initExtra = ''
          eval "$(zoxide init zsh)"

          # Alias functions
          gitc() {
            git clone ssh://git@github.com/$1/$2.git
          }
          '';
        };
        bash = {
          enable = true;
          initExtra = "zsh";
        };
        neovim = {
          enable = true;
          extraConfig = "so " + dotfiles + "/neovim/neovim.vim";
          plugins = with pkgs.vimPlugins; [
            telescope-nvim
            nvim-lspconfig
            nvim-cmp
            cmp-nvim-lsp
            onedark-nvim
            lightline-vim
            fidget-nvim
            snippets-nvim
            vim-gitgutter
            dashboard-nvim
            vim-commentary
            nvim-surround
            emmet-vim
            nvim-treesitter.withAllGrammars
          ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    python3
    rustc
    cargo
    rustfmt
    gcc
    nodePackages.pyright
    #polybar
    #dmenu
    killall
    blueberry
    zip
    unzip
    pavucontrol
    wofi
    hyprpaper
    waybar
    #xdg-desktop-portal-hyprland
    wl-clipboard
    grim
    slurp
    wireguard-tools
    dig
    mpvpaper
    hyprsome.packages.${system}.default
  ];

  systemd.user.services = {
    xbindkeys = {
      enable = false;
      description = "Keybinds!";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      serviceConfig.ExecStart = "${pkgs.xbindkeys}/bin/xbindkeys";
    };
    blueberry = {
      enable = false;
      description = "Bluetooth applet!";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      serviceConfig.ExecStart = "${pkgs.blueberry}/bin/blueberry-tray";
    };

  };

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome_6
  ];

  # Patches
  nixpkgs.overlays = [
    (self: super: {
      /* dwm = super.dwm.overrideAttrs (oldAttrs: rec { */
      /*   src = pkgs.fetchFromGitHub { */
      /*     owner = "tagepicdotfiles"; */
      /*     repo = "dwm"; */
      /*     rev = "c2cc0efebb4d3e9b2f8615a36551ec6a6b64e93f"; */
      /*     sha256 = "sha256-w/oUkmrT8CIm7FhG1s01EJwuMVSaod8Z/mIiZ31l+EA="; */
      /*   }; */
      /*   buildInputs = oldAttrs.buildInputs ++ [ pkgs.yajl ]; */
      /*   configFile = pkgs.writeText "config.def.h" ( */
      /*     builtins.readFile(builtins.fetchurl("https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/dwmconfig.h")) */
      /*   ); */
      /*   postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h"; */
      /* }); */
      /* polybar = super.polybar.overrideAttrs (oldAttrs: rec { */
      /*   src = pkgs.fetchFromGitHub { */
      /*     owner = "dakata1337"; */
      /*     repo = "polybar-dwm-module"; */
      /*     rev = "229846f79143f268b5453cbc68fa69201367cdb5"; */
      /*     sha256 = "sha256-ljHTrJ1FgFobRmneUuq88lvQrnSiIYihsoVepkF/ZOg="; */
      /*     fetchSubmodules = true; */
      /*   }; */
      /*   patches = []; # Not neccesary, just causes problems */
      /*   buildInputs = oldAttrs.buildInputs ++ [ pkgs.jsoncpp ]; */
      /* }); */
      waybar = super.waybar.overrideAttrs (oldAttrs: rec {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        preBuildPhase = "sed -i -e 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = \"hyprctl dispatch workspace \" + name_;\\n\\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp";
      });
      # Wayland wrappers
      /*
      signal-desktop = super.signal-desktop.overrideAttrs (oldAttrs: rec {
        preFixup = oldAttrs.preFixup + ''
            gappsWrapperArgs+=(
                --add-flags "--enable-features=UseOzonePlatform"
                --add-flags "--ozone-platform=wayland"
            )
        '';
      });
      */
    })
  ];

  # Add 32 bit drivers for steam
  hardware.opengl.driSupport32Bit = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
