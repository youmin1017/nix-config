{ lib, config, ... }:
{

  virtualisation.oci-containers.containers = {
    minio-console = {
      image = "ghcr.io/wkebaas/wkedrive:v0.1.1";
      ports = [ "127.0.0.1:8080:8080" ];
      environmentFiles = [
        config.sops.secrets."env/wkedrive".path
      ];
    };
  };

  services.caddy.virtualHosts."drive.dev.wke.csie.ncnu.edu.tw" = {
    extraConfig = ''
      handle /api/auth* {
        reverse_proxy https://codeoxfsjfvdzsrgggkz.baas.wke.csie.ncnu.edu.tw
      }
      handle * {
        reverse_proxy http://localhost:8080
      }
    '';
  };

  sops.secrets."env/wkedrive" = {
    sopsFile = lib.custom.relativeToRoot "secrets/wkedrive.yaml";
  };
}
