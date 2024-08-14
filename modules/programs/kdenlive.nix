{username, ...}:
{pkgs, ...}:
{
    users.users.${username}.packages = with pkgs; [
        kdenlive
    ];
}
