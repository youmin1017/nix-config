{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.programs.zen-browser;
in
{
  options.myNixOS.programs.zen-browser.enable = pkgs.lib.mkEnableOption "Zen Browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      self.inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
  };
}
