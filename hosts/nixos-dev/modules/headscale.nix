# This module required enaable services separately
#
# Prerequisites:
# - Postgres database for headscale
# - OIDC provider for headscale
#
# Setup:
# 1. headscale
# 2. headscale-admin
# 3. tailscale (up as exit node and advertise routes)
{ config, ... }:
{
  services.headscale = {
    enable = true;
    port = 12000;

    settings = {
      server_url = "https://vpn.wke.csie.ncnu.edu.tw";
      database = {
        type = "postgres";
        postgres = {
          host = "localhost";
          port = 5432;
          user = "headscale";
          name = "headscale";
          password_file = config.sops.secrets."hosts/nixos-dev/postgresql/users/headscale/password".path;
        };
      };
      dns = {
        magic_dns = false;
        override_local_dns = true;
        nameservers.global = [
          "163.22.21.44"
          "163.22.2.1"
          "163.22.2.2"
        ];
      };
      oidc = {
        only_start_if_oidc_is_available = true;
        issuer = "https://auth.wke.csie.ncnu.edu.tw/realms/wke";
        client_id = "vpn";
        scope = [
          "openid"
          "profile"
          "email"
        ];
        pkce = {
          enabled = true;
          method = "S256"; # Use SHA256 hashed code verifier (default, recommended)
        };
      };
    };
  };

  # headscale-ui
  virtualisation.oci-containers.containers = {
    headscale-admin = {
      image = "goodieshq/headscale-admin:0.26";
      ports = [ "127.0.0.1:12080:80" ];
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    authKeyFile = config.sops.secrets."hosts/nixos-dev/tailscale/authkey".path;
    extraUpFlags = [
      "--advertise-exit-node"
      "--advertise-routes=10.0.0.0/8"
      "--accept-routes"
      "--accept-dns=false"
      "--login-server=${config.services.headscale.settings.server_url}"
    ];
  };

  sops.secrets."hosts/nixos-dev/postgresql/users/headscale/password".owner = "headscale";
  sops.secrets."hosts/nixos-dev/tailscale/authkey".mode = "0600";
}
