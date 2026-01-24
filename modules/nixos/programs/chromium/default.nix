{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.programs.chromium;
in
{
  options.myNixOS.programs.chromium.enable = lib.mkEnableOption "Chromium web browser";

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
    };
  };
}
