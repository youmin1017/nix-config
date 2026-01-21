{ config, lib, ... }:
{
  imports = [
    ./desktop
    ./dev
    ./profiles
    ./services
    ./programs
  ];

  options.myHome.flakeRoot = lib.mkOption {
    description = "the flake root path for make dotfiles symlinks";
    type = lib.types.str;
    default = "${config.home.homeDirectory}/.config/nix";
  };
}
