{ config, lib, ... }:
let
  cfg = config.myHome.services.nm-applet;
in
{
  options.myHome.services.nm-applet.enable =
    lib.mkEnableOption "NetworkManager applet for system tray";

  config = lib.mkIf cfg.enable {
    services.network-manager-applet.enable = true;
  };
}
