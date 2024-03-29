{username, inputs, system, ...}:
{pkgs, ...}:
let
    module_path = "${inputs.self}/overrides/sylveon/hyprland-remote-host";
    wallpaper = "${inputs.wallpaper-collection}/images/dataxiii-upscaled-vector-landscape.jpg";
in {
    home-manager.users.${username} = {
        home.file = {
            # Hyprland
            ".config/hypr/hyprland.conf".source = "${module_path}/hyprland.conf";
            ".config/hypr/hyprpaper.conf".text = ''
            preload = ${wallpaper}
            wallpaper = ,${wallpaper}
            '';
        };
    };
    environment.systemPackages = with pkgs; [
        hyprpaper
        hyprland
        
        # Open window
        wofi
    ];
    
    # Input on X11 apps
    services.xserver.libinput.enable = true;
}
