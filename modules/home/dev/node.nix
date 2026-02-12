{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.node.enable = lib.mkEnableOption "Enable node development environment";

  config = lib.mkIf config.myHome.dev.node.enable {
    home.packages = with pkgs; [
      nodejs_24
      pnpm
      bun
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.typescript"
        "lazyvim.plugins.extras.linting.eslint"
        "lazyvim.plugins.extras.lang.json"
        "lazyvim.plugins.extras.lang.toml"
        "lazyvim.plugins.extras.lang.yaml"
      ];
    };
  };
}
