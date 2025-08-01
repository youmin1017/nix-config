{ config, ... }:
let
  zitadelPort = toString config.services.zitadel.settings.Port;
  headscalePort = toString config.services.headscale.port;
in
{
  services.caddy = {
    enable = true;
    email = "crustal-polled9g@icloud.com";

    virtualHosts."sso.youmin.dev" = {
      extraConfig = ''
        reverse_proxy h2c://localhost:${zitadelPort}
      '';
    };

    virtualHosts."vpn.youmin.dev" = {
      extraConfig = ''
        reverse_proxy /admin* http://localhost:12080
        reverse_proxy * http://localhost:${headscalePort}
      '';
    };

    extraConfig = ''
      youmin.dev *.youmin.dev {
        tls ${config.sops.secrets."domains/youmin.dev/ssl/cert".path} ${
          config.sops.secrets."domains/youmin.dev/ssl/key".path
        }
      }
    '';
  };

  sops.secrets."domains/youmin.dev/ssl/key".mode = "0644";
  sops.secrets."domains/youmin.dev/ssl/cert".mode = "0644";
}
