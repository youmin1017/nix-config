{ config, ... }:
let
  headscalePort = toString config.services.headscale.port;
  keycloakPort = toString config.services.keycloak.settings.http-port;
in
{
  services.caddy = {
    enable = true;
    # package = pkgs.caddy.withPlugins {
    #   plugins = [ "github.com/greenpau/caddy-security@v1.1.31" ];
    #   hash = "sha256-UzwXT5U8ThAM5wRXERdpncOX9J+aDeNLPXPo6W1eV9g=";
    # };

    virtualHosts."auth.wke.csie.ncnu.edu.tw" = {
      extraConfig = ''
        reverse_proxy http://localhost:${keycloakPort}
      '';
    };

    virtualHosts."vpn.wke.csie.ncnu.edu.tw" = {
      extraConfig = ''
        reverse_proxy /admin* http://localhost:12080
        reverse_proxy * http://localhost:${headscalePort}
      '';
    };

    extraConfig = ''
      *.wke.csie.ncnu.edu.tw {
        tls ${config.age.secrets."wke-ssl.cert".path} ${config.age.secrets."wke-ssl.key".path}
      }
    '';
  };

  age.secrets = {
    "wke-ssl.cert" = {
      file = ../../../secrets/wke-ssl.cert.age;
      owner = "caddy";
    };
    "wke-ssl.key" = {
      file = ../../../secrets/wke-ssl.key.age;
      owner = "caddy";
    };
  };
}
