{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.programs.limine;
in
{
  options.myNixOS.programs.limine.enable = lib.mkEnableOption "enable lanzaboote";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sbctl
    ];

    boot.loader.limine = {
      enable = true;
      secureBoot.enable = lib.mkDefault true;
      maxGenerations = lib.mkDefault 5;
    };
  };
}
