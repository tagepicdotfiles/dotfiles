{...}:
{...}:
{
    networking.firewall.allowedTCPPorts = [
        5173 # Svelte apps - for debugging
        8972 # HTB
        8971 # HTB revshell
    ];
    networking.firewall.allowedUDPPorts = [];
}
