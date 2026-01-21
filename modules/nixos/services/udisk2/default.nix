{
  config,
  lib,
  ...
}:
{
  options.myNixOS.services.udisks2.enable = lib.mkEnableOption "udisks2 server";

  config = lib.mkIf config.myNixOS.services.udisks2.enable {
    services.udisks2.enable = true;
  };
}
