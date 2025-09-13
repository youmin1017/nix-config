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
    rootCredentialsFile = config.sops.secrets."env/minio/root_credentials".path;
    listenAddress = ":9000";
    consoleAddress = ":9001";
    region = "tw-1";
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

  sops.secrets."env/minio/root_credentials" = {
    sopsFile = lib.custom.relativeToRoot "secrets/minio.yaml";
  };
}
