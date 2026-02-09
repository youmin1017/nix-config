{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.services.gdm;
in
{

  options.myNixOS.services.gdm = {
    enable = lib.mkEnableOption "Enable GDM display manager";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.gdm = {
      enable = true;
      # defaultSession = "hyprland";
    };
  };
}
