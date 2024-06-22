{username, inputs, ...}:
{pkgs, ...}:
let
    module_path = "${inputs.self}/modules/programs/alacritty";
in
{
    home-manager.users.${username} = {
        home.file = {
            ".config/alacritty/alacritty.toml".source = "${module_path}/config.toml";
        };
    };
    users.users.${username}.packages = with pkgs; [
        alacritty
    ];
}
