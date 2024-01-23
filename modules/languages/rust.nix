{...}:
{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        clippy
        rustc
        rustfmt
        cargo
    ];
}
