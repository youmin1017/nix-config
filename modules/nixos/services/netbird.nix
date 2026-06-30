{ config, lib, ... }:
let
  cfg = config.myNixOS.services.netbird;
in
{
  options.myNixOS.services.netbird = {
    enable = lib.mkEnableOption "Enable NetBird service";
  };

  config = lib.mkIf cfg.enable {
    services.resolved.enable = true;
    services.netbird = {
      ui.enable = true;
      clients = {
        wt0 = {
          port = 51820;
          openFirewall = true;
          openInternalFirewall = true;
        };
      };
    };
  };
}
