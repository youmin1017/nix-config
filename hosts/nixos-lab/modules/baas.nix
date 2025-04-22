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

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";

    containers.traefik = {
      image = "traefik:v3.3.6";
      autoStart = true;
      ports = [
        "80:80"
        "443:443"
        "5432:5432"
        "8080:8080"
      ];

      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/etc/traefik:/etc/traefik"
        "${config.sops.secrets."lab/baas/ssl/wildcard_local/key".path}:/certs/local_key.pem"
        "${config.sops.secrets."lab/baas/ssl/wildcard_local/cert".path}:/certs/local_cert.pem"
      ];

      cmd = [
        "--api.insecure=true"
        "--entrypoints.web.address=:80"
        "--entrypoints.postgres.address=:5432"
        "--providers.docker=true"
        "--providers.docker.exposedbydefault=false"
        "--providers.docker.network=traefik"
      ];

      networks = [
        "traefik"
      ];
    };
  };

  environment.etc."traefik/dynamic/tls.yaml".text = ''
    tls:
      certificates:
        - certFile: /certs/local_cert.pem
          keyFile: /certs/local_key.pem
  '';

  sops.secrets = {
    "lab/baas/ssl/wildcard_local/key" = { };
    "lab/baas/ssl/wildcard_local/cert" = { };
  };
}
