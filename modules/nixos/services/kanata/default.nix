{ config, lib, ... }:
let
  cfg = config.myNixOS.services.kanata;
in
{
  options.myNixOS.services.kanata = {
    enable = lib.mkEnableOption "Kanata keyboard comfort and usability with advanced customization";
  };

  imports = [ ./keyboards ];

  config = lib.mkIf cfg.enable {
    services.kanata = {
      enable = true;
    };
  };
}
