export domain="sylveon.home.arpa"
nixos-rebuild switch --flake .#sylveon --target-host ${domain} --build-host ${domain} --use-remote-sudo
