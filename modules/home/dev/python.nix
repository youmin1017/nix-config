{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.python.enable = lib.mkEnableOption "Enable Python development environment";

  config = lib.mkIf config.myHome.dev.python.enable {
    home.packages = with pkgs; [
      python3
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.python"
      ];
    };
  };
}
