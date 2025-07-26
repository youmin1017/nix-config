{ config, ... }:
let
  zitadelPort = toString config.services.zitadel.settings.Port;
in
{
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web.address = ":80";
        websecure.address = ":443";
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          zitadel = {
            entryPoints = [ "websecure" ];
            service = "zitadel";
            rule = "PathPrefix(`/`)";
            tls = { };
          };
        };
        services.zitadel.loadBalancer.servers = [
          {
            url = "h2c://localhost:${zitadelPort}";
          }
        ];
      };
      tls = {
        stores = {
          default = {
            defaultCertificate = {
              certFile = config.sops.secrets."wke/ssl/cert".path;
              keyFile = config.sops.secrets."wke/ssl/key".path;
            };
          };
        };
      };
    };
  };

  sops.secrets."wke/ssl/cert".owner = "traefik";
  sops.secrets."wke/ssl/key".owner = "traefik";
}
