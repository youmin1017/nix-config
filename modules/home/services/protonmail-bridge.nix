{
  lib,
  config,
  ...
}:
let
  cfg = config.myHome.services.protonmail-bridge;
in
{
  options.myHome.services.protonmail-bridge.enable = lib.mkEnableOption "protonmail-bridge service";

  config = lib.mkIf cfg.enable {
    services.protonmail-bridge = {
      enable = true;
    };
  };
}
