{ config, ... }:
let
  # headscalePort = toString config.services.headscale.port;
  keycloakPort = toString config.services.keycloak.settings.http-port;
in
{
  services.caddy = {
    enable = true;

    virtualHosts."auth.wke.csie.ncnu.edu.tw" = {
      extraConfig = ''
        reverse_proxy http://localhost:${keycloakPort}
      '';
    };

    # virtualHosts."vpn.youmin.dev" = {
    #   extraConfig = ''
    #     reverse_proxy /admin* http://localhost:12080
    #     reverse_proxy * http://localhost:${headscalePort}
    #   '';
    # };

    extraConfig = ''
      youmin.dev *.youmin.dev {
        tls ${config.sops.secrets."domains/youmin.dev/ssl/cert".path} ${
          config.sops.secrets."domains/youmin.dev/ssl/key".path
        }
      }
      *.wke.csie.ncnu.edu.tw {
        tls ${config.sops.secrets."wke/ssl/cert".path} ${config.sops.secrets."wke/ssl/key".path}
      }
    '';
  };

  sops.secrets."domains/youmin.dev/ssl/key".mode = "0644";
  sops.secrets."domains/youmin.dev/ssl/cert".mode = "0644";
  sops.secrets."wke/ssl/cert".mode = "0644";
  sops.secrets."wke/ssl/key".mode = "0644";
}
