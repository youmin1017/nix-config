{ config, lib, ... }:
{
  options.myHome.dev.docker.enable = lib.mkEnableOption "Enable Docker development environment";

  config = lib.mkIf config.myHome.dev.docker.enable {
    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.docker"
      ];
    };
  };
}
