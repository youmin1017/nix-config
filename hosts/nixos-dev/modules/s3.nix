# S3 via MinIO
{
  lib,
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    minio-client
  ];

  services.minio = {
    enable = true;
    rootCredentialsFile = config.age.secrets."minio-root-credentials".path;
    listenAddress = ":9000";
    consoleAddress = ":9001";
    region = "tw-1";
  };

  virtualisation.oci-containers.containers = {
    minio-console = {
      image = "ghcr.io/huncrys/minio-console:v1.8.1";
      ports = [ "127.0.0.1:9090:9090" ];
      environmentFiles = [
        config.age.secrets."minio-console".path
      ];
    };
  };

  services.caddy.virtualHosts."s3.dev.wke.csie.ncnu.edu.tw" = {
    extraConfig = ''
      reverse_proxy http://localhost:9090
    '';
  };
  services.caddy.virtualHosts."s3.wke.csie.ncnu.edu.tw" = {
    extraConfig = ''
      handle /minio/ui* {
        uri strip_prefix /minio/ui
        reverse_proxy http://localhost:9001
      }
      handle * {
        reverse_proxy http://localhost:9000
      }
    '';
  };

  age.secrets = {
    "minio-root-credentials" = {
      file = ../../../secrets/minio-root-credentials.age;
    };
    "minio-console" = {
      file = ../../../secrets/minio-console.age;
    };
  };
}
