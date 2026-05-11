{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.services.ly;
in
{

  options.myNixOS.services.ly = {
    enable = lib.mkEnableOption "Enable ly display manager";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
