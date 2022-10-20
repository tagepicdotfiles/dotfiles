{ config, pkgs, ... }:
let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "tagepicdotfiles";
    repo = "dotfiles";
    rev = "5cba525a3b51804d50825f8a194d2caebaca1fe1";
    sha256 = "sha256-vVsWW2C8nW5qH7qIq4S3AFtzdzXvBG2/Gz0hFV7h7YQ=";
  };
in
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
  services.picom.enable = true;
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
    };
    windowManager.dwm.enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        background = pkgs.fetchFromGitHub {
          owner = "DenverCoder1";
          repo = "minimalistic-wallpaper-collection";
          rev = "eeb7aed40c8bcae614c48a4a17913e9ffd2d809b";
          sha256 = "8LH5Nc1krDmRXLk0/2b+RMlgNInNtioSoQNeId74KGM=";
        } + "/images/alena-aenami-escape.jpg";
      };
      startx.enable = true;
    };
  };

  # Pritning via CUPS
  services.printing.enable = true;

  programs.nm-applet.enable = true;

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
      # Revert to using multimc or similar?
      # polymc
      btop
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
      brightnessctl
      prusa-slicer
      cloc
      gh
      onefetch
      vscode
      ripgrep
      thunderbird
      arandr
      xonotic
      thefuck
      bore-cli
      blender
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.epic = { pkgs, ...}: {
      home = {
        file = {
          ".config/oh-my-zsh/epic.zsh-theme".source = dotfiles + "/epic.zsh-theme";
          ".xbindkeysrc".source = dotfiles + "/xbindkeysrc";
          ".config/alacritty/alacritty.yml".source = dotfiles + "/alacritty.yml";

          # Polybar
          ".config/polybar/bar.sh".source = dotfiles + "/polybar/startbar.sh";
          ".config/polybar/polybar.ini".source = dotfiles + "/polybar/polybar.ini";
          ".config/polybar/scripts/get_volume.sh".source = dotfiles + "/polybar/scripts/get_volume.sh";

          # NeoVIM
          ".config/nvim/init.vim".source = dotfiles + "/neovim.vim";
          ".local/share/nvim/site/autoload/plug.vim".source = builtins.fetchurl(
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          );
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
            pushpwd = "scp ~/.config/keepassxc/Passwords.kdbx root@vulpix.farfrom.world:~/Passwords.kdbx";
            pullpwd = "scp root@vulpix.farfrom.world:~/Passwords.kdbx ~/.config/keepassxc/Passwords.kdbx";
            cd = "z";
            nix = "nix --experimental-features nix-command";
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
