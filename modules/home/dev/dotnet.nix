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
    sdk = lib.mkPackageOption pkgs "dotnet-sdk_10" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.sdk
    ];

    home.sessionVariables = {
      DOTNET_ROOT = "${cfg.sdk}/share/dotnet";
    };

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.dotnet"
      ];
    };
  };
}
