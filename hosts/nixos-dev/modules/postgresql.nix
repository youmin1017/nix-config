{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    5432
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    enableTCPIP = true;

    authentication = ''
      host  all all 10.21.27.223/32 scram-sha-256
    '';
  };
}
