{username, ...}:
{pkgs, ...}:
{
    users.users.${username}.packages = with pkgs; [
        zoxide
    ];
    home-manager.users.${username}.programs.zsh = {
        shellAliases = {
            cd = "z";
        };
        initExtra = "eval \"$(zoxide init zsh)\"";
    };
}
