{username, ...}:
{pkgs, ...}:
{
    home-manager.users.${username}.programs.firefox = {
        enable = true;


    profiles.main = {
        isDefault = true;
        search = {
            default = "DuckDuckGo";
            force = true;
        };
        settings = {
            # Disable swipe navigation
            "browser.gesture.swipe.left" = "";
            "browser.gesture.swipe.right" = "";

            # Disable zoom gesture
            "browser.gesture.pinch.in" = "";
            "browser.gesture.pinch.out" = "";

            # Hide "Import bookmarks" button
            "browser.bookmarks.addedImportButton" = false;

            # Metrics
            "toolkit.telemetry.enabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
        };
        bookmarks = [
            {
                toolbar = true;
                bookmarks = [
                    {
                        name = "Nixpkgs";
                        url = "https://search.nixos.org/packages";
                    }
                    {
                        name = "Home Manager";
                        url = "https://nix-community.github.io/home-manager/options.xhtml";
                    }
                ];
            }
        ];
    };
    };
}
