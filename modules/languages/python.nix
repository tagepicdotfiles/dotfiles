{username, inputs, ...}:
{pkgs, ...}: {
    users.users.${username}.packages = with pkgs; [
        poetry

        # 3.8
        #python38
        #python38Packages.pip

        # 3.11
        python311
        python311Packages.pip

        # 3.12
        python312
        #python312Packages.pip

        # 3.13
        #python313
        #python313Packages.pip
    ];
}
