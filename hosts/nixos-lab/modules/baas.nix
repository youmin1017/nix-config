{ ... }:
{

  # Network Configuration
  networking.firewall.allowedTCPPorts = [
    53
    80
    443
  ];
  networking.nameservers = [ "127.0.0.1" ];
  networking.resolvconf.useLocalResolver = true;
  services.dnsmasq = {
    enable = true;
    settings = {
      address = [
        "/.baas.local/127.0.0.1"
        "/.auth.local/127.0.0.1"
      ];
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."baas.local" = {
      extraConfig = ''
        reverse_proxy /api/auth* http://localhost:3000
        reverse_proxy http://localhost:5173
      '';
    };
  };

  # sops.secrets = {
  #   # The cert files will be placed in /run/secrets/lab/ssl/wildcard_local/cert
  #   "domain/baas.local/ssl/key" = { };
  #   "domain/baas.local/ssl/cert" = { };
  # };
}
