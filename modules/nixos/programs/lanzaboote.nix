{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.programs.lanzaboote;
in
{
  options.myNixOS.programs.lanzaboote.enable = lib.mkEnableOption "enable lanzaboote";

  config = lib.mkIf cfg.enable {
    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    environment.systemPackages = with pkgs; [
      sbctl
    ];

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = lib.mkDefault true;
      autoEnrollKeys.enable = lib.mkDefault true;
      configurationLimit = lib.mkDefault 5;
    };
  };
}
