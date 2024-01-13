{username, inputs, ...}:
{pkgs, ...}:
let
    module_path = "${inputs.self}/modules/programs/zsh";
in
{
    programs.zsh.enable = true;
    users.users.${username}.shell = pkgs.zsh;
    home-manager.users.${username} = {
        home.file = {
            ".config/oh-my-zsh/epic.zsh-theme".source = "${module_path}/epic.zsh-theme";
        };
        programs.zsh = {
            enable = true;
            oh-my-zsh = {
                enable = true;
                theme = "epic";
                plugins = ["git"];
                custom = "$HOME/.config/oh-my-zsh/";
            };
        };
    };
}
