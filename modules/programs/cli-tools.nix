{...}:
{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        gdb
        jq
        jless
        btop
        ripgrep
        neofetch
        gdb
        bore-cli
        zip
        unzip
        killall
        wget
        dig

        # Breaks ls atm
        #cope
    ];
}
