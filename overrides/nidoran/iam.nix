{...}:
{pkgs, ...}: {
    systemd = {
        timers.iam = {
            wantedBy = ["timers.target"];
            timerConfig = {
                Unit = "iam.service";
                Persistent = true;
                OnCalendar = "Sat *-*-* 12:00:00 Europe/Oslo";
            };
        };
        services.iam = {
            script = "${pkgs.nix}/bin/nix shell nixpkgs#python3 nixpkgs#poetry --command poetry run --directory /home/epic/iam python3 /home/epic/iam/start.py";
            serviceConfig = {
                Type = "oneshot";
                User = "epic";
            };
        };
    };
}
