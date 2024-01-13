{username, ...}:
{pkgs, ...}:
{
    users.users.${username}.packages = with pkgs; [
        waypipe
    ];
}
