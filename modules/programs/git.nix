{username, ...}:
{pkgs, ...}:
{
    home-manager.users.${username}.programs.git = {
        enable = true;
        userName = "TAG-Epic";
        userEmail = "tagepicuwu@gmail.com";
        delta.enable = true; # Better diff formatting
        ignores = [
            ".dev"
        ];
        extraConfig = {
            pull = {
                rebase = true;
            };
            push.autoSetupRemote = true;
            init.defaultBranch = "main";
            credential.helper = "store"; # Store plaintext creds (for gh tokens)
        };
    };
}
