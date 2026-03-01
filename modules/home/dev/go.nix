{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.go.enable = lib.mkEnableOption "Enable Go development environment";

  config = lib.mkIf config.myHome.dev.go.enable {
    home.packages = with pkgs; [
      go
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.go"
      ];
    };
  };
}
