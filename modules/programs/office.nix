{username, ...}:
{pkgs, ...}: {
    users.users.${username}.packages = with pkgs; [
        libreoffice

        # Spell check
        hunspell
        hunspellDicts.en_US
        hunspellDicts.nb_NO
    ];
}
