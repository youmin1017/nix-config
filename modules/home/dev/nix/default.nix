{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.nix.enable = lib.mkEnableOption "Enable Nix development environment";

  config = lib.mkIf config.myHome.dev.nix.enable {
    home.packages = with pkgs; [
      nil
      nixd
      nixfmt
      statix
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.nix"
      ];
    };
  };
}
