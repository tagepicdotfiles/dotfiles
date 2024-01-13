{...}:
{pkgs, ...}: {
    boot.loader = {
        systemd-boot.enable = true;
        #efi.canTouchEfiVariables = true;
        #efi.efiSysMountPoint = "/boot/EFI";
    };
}
