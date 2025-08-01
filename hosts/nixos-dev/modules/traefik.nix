{ config, ... }:
let
  zitadelPort = toString config.services.zitadel.settings.Port;
  headscalePort = toString config.services.headscale.port;
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
          headscale = {
            entryPoints = [ "websecure" ];
            service = "headscale";
            rule = "Host(`dev_vpn.wke.csie.ncnu.edu.tw`)";
            tls = { };
          };
        };
        services.zitadel.loadBalancer.servers = [
          {
            url = "h2c://localhost:${zitadelPort}";
          }
        ];
        services.headscale.loadBalancer.servers = [
          {
            url = "http://localhost:${headscalePort}";
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
