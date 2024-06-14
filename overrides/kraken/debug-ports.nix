{...}:
{...}:
{
    networking.firewall.allowedTCPPorts = [
        5173 # Svelte apps - for debugging
        9999 # Generic debug port
    ];
    networking.firewall.allowedUDPPorts = [
        9999 # Generic debug port
    ];
}
