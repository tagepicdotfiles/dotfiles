{username, inputs, ...}:
{pkgs, ...}:
let
    module_path = "${inputs.self}/modules/programs/alacritty";
in
{
    home-manager.users.${username} = {
        home.file = {
            ".config/alacritty/alacritty.yml".source = "${module_path}/config.yml";
        };
    };
    users.users.${username}.packages = with pkgs; [
        alacritty
    ];
}
