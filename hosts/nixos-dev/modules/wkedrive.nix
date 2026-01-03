{ lib, config, ... }:
{

  virtualisation.oci-containers.containers = {
    wke-drive = {
      image = "ghcr.io/wkebaas/wkedrive:v0.1.4";
      ports = [ "127.0.0.1:8080:3000" ];
      environmentFiles = [
        config.sops.secrets."env/wkedrive".path
      ];
    };
  };

  services.caddy.virtualHosts."drive.dev.wke.csie.ncnu.edu.tw" = {
    extraConfig = ''
      handle /api/auth* {
        reverse_proxy https://codeoxfsjfvdzsrgggkz.baas.wke.csie.ncnu.edu.tw {
          header_up Host {upstream_hostport}
        }
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
