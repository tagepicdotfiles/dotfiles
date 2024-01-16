{username, inputs, system, ...}:
{pkgs, ...}:
let
    module_path = "${inputs.self}/modules/programs/hyprland";
    wallpaper = "${inputs.wallpaper-collection}/images/dataxiii-upscaled-vector-landscape.jpg";
in {
    programs = {
        hyprland.enable = true;
        waybar.enable = true;
    };

    home-manager.users.${username} = {
        home.file = {
            # Waybar
            ".config/waybar/config".source = "${module_path}/waybar/config.json";
            ".config/waybar/style.css".source = "${module_path}/waybar/style.css";

            # Hyprland
            ".config/hypr/hyprland.conf".text = builtins.replaceStrings ["hyprsome"] ["${inputs.hyprsome.packages.${system}.default}/bin/hyprsome"](builtins.readFile "${module_path}/hyprland.conf");
            ".config/hypr/hyprpaper.conf".text = ''
            preload = ${wallpaper}
            wallpaper = ,${wallpaper}
            '';
        };
    };
    environment.systemPackages = with pkgs; [
        inputs.hyprsome.packages.${system}.default
        hyprpaper

        # Screenshot
        grim
        slurp
        wl-clipboard

        # Open window
        wofi
    ];

    # Waybar font
    fonts.packages = with pkgs; [
        font-awesome_6
    ];

    # Input on X11 apps
    services.xserver.libinput.enable = true;
}
