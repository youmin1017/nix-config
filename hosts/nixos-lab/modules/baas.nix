{ config, ... }:
{
  # Network Configuration
  networking.firewall.allowedTCPPorts = [
    53
    80
    5432
  ];
  networking.nameservers = [ "127.0.0.1" ];
  networking.resolvconf.useLocalResolver = true;
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.baas.local/127.0.0.1";
    };
  };

  # Virtualization
  virtualisation.docker.enable = true;

  sops.secrets = {
    # The cert files will be placed in /run/secrets/lab/ssl/wildcard_local/cert
    "lab/baas/ssl/wildcard_local/key" = { };
    "lab/baas/ssl/wildcard_local/cert" = { };
  };
}
