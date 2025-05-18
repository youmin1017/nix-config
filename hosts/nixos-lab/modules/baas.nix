{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  # Network Configuration
  networking.firewall.allowedTCPPorts = [
    53
    80
    5432
    6443
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

  ##### K3s #####
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      "--disable=traefik"
    ];
  };

  ##### K3s Required Services #####
  # used for longhorn
  services.openiscsi = {
    enable = true;
    name = "iqn.2025-01.tw.edu.ncnu.csie.wke.cloud:nixos-lab";
  };

  sops.secrets = {
    # The cert files will be placed in /run/secrets/lab/ssl/wildcard_local/cert
    "lab/baas/ssl/wildcard_local/key" = { };
    "lab/baas/ssl/wildcard_local/cert" = { };
  };
}
