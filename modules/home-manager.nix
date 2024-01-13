{username, ...}: 
{pkgs, ...}: {
    home-manager = {
        useGlobalPkgs = true;
        users.${username} = {
            home.stateVersion = "22.05";
            manual.manpages.enable = false; # Temporary fix as sr.ht is down
        };
    };
}
