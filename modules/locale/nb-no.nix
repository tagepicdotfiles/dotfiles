{...}:
{pkgs, ...}: {
    services.xserver.layout = "no";
    time.timeZone = "Europe/Oslo";
    console.keyMap = "no";
}
