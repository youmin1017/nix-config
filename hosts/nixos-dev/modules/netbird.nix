{ config, ... }:
{
  services.resolved.enable = true;
  services.netbird = {
    clients.default = {
      name = "netbird";
      port = 51820;
      interface = "wt0";
      hardened = false;
      openFirewall = true;
      openInternalFirewall = true;
      login = {
        enable = true;
        setupKeyFile = config.age.secrets."netbird-wt0-setup-key".path;
      };
    };
  };

  age.secrets = {
    "netbird-wt0-setup-key".file = ../../../secrets/netbird-wt0-setup-key.age;
  };
}
