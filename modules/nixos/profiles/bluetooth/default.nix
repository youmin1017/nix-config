{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixOS.profiles.bluetooth.enable = lib.mkEnableOption "bluetooth support";

  config = lib.mkIf config.myNixOS.profiles.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
