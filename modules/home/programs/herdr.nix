{
  self,
  config,
  lib,
  pkgs,
  impurity,
  ...
}:
{
  options.myHome.programs.herdr.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.myHome.programs.herdr.enable {
    home.packages = with pkgs; [
      herdr
    ];

    xdg.configFile."herdr".source = impurity.link "${self}/dotfiles/herdr";
  };
}
