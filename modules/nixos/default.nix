{ lib, ... }:
{
  imports = [
    ./base.nix
    ./desktop
    ./profiles
    ./services
    ./programs
  ];

  options.myNixOS.FLAKE = lib.mkOption {
    type = lib.types.str;
    default = "github:alyraffauf/nixcfg";
    description = "Default flake URL for this NixOS configuration.";
  };
}
