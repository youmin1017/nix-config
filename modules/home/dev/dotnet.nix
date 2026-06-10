{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.dev.dotnet;
in
{
  options.myHome.dev.dotnet = {
    enable = lib.mkEnableOption "dotnet development environment configuration.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dotnet-sdk_10
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.dotnet"
      ];
    };
  };
}
