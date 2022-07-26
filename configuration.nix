{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kraken";

  # Networking
  networking.wireless.enable = false;  # wpa_supplicant # TODO: Switch to this
  networking.networkmanager.enable = true;  # I currently use this because of GNOME

  # Firewall
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";


  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "no";
  services.xserver.layout = "no";

  # WM/DE
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
    };
    windowManager.dwm.enable = true;
    displayManager = {
      lightdm.enable = true;
      startx.enable = true;
    };
    #desktopManager.gnome.enable = true;
  };

  # Pritning via CUPS
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.epic = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      discord
      libreoffice
      spotify
      keepassxc
      polymc
      bpytop
      neofetch
      pfetch
      zoxide
      signal-desktop
      steam
      obsidian
      alacritty
      maim
      xclip
      xbindkeys
      playerctl
      poetry
      nodePackages.pyright
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.epic = { pkgs, ...}: {
      home = {
        file = {
          ".config/oh-my-zsh/epic.zsh-theme".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/epic.zsh-theme"
          );
          ".xbindkeysrc".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/xbindkeysrc"
          );
          ".config/alacritty/alacritty.yml".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/alacritty.yml"
          );

          # NeoVIM
          ".config/nvim/init.vim".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/neovim.vim"
          );
          ".local/share/nvim/site/autoload/plug.vim".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          );
        };
        sessionVariables = {
          EDITOR = "nvim";
          TERM = "xterm-256color";
        };
      };
      programs = {
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
            pushpwd = "scp ~/.config/keepassxc/passwords.kdbx root@vulpix.farfrom.world:~/Passwords.kdbx";
            pullpwd = "scp root@vulpix.farfrom.world:~/Passwords.kdbx ~/.config/keepassxc/Passwords.kdbx";
            cd = "z";
            nix = "nix --experimental-features nix-command";
            nix-view = "nix --experimental-features nix-command edit -f '<nixpkgs>'";
          };
          initExtra = ''
          eval "$(zoxide init zsh)"
          '';
        };
        bash.enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    python3
    rustc
    cargo
    gcc
    nodePackages.pyright
    polybar
    dmenu
    killall
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    font-awesome_6
  ];

  # Patches
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitHub {
          owner = "tagepicdotfiles";
          repo = "dwm";
          rev = "c2cc0efebb4d3e9b2f8615a36551ec6a6b64e93f";
          sha256 = "sha256-w/oUkmrT8CIm7FhG1s01EJwuMVSaod8Z/mIiZ31l+EA=";
        };
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.yajl ];
        configFile = pkgs.writeText "config.def.h" (
          builtins.readFile(builtins.fetchurl("https://raw.githubusercontent.com/tagepicdotfiles/dotfiles/master/dwmconfig.h"))
        );
        postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
      });
      polybar = super.polybar.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitHub {
          owner = "dakata1337";
          repo = "polybar-dwm-module";
          rev = "229846f79143f268b5453cbc68fa69201367cdb5";
          sha256 = "sha256-ljHTrJ1FgFobRmneUuq88lvQrnSiIYihsoVepkF/ZOg=";
          fetchSubmodules = true;
        };
        patches = []; # Not neccesary, just causes problems
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.jsoncpp ];
      });
    })
  ];

  # Add 32 bit drivers for steam
  hardware.opengl.driSupport32Bit = true;



  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
