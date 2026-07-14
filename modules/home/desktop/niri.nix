{
  self,
  impurity,
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.desktop.niri;
in
{
  options.myHome.desktop.niri = {
    enable = lib.mkEnableOption "niri desktop environment";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "niri".source = impurity.link "${self}/dotfiles/niri";
    };

    myHome = {
      desktop.enable = true;

      profiles = {
        cursor.enable = true;
        dconf.enable = true;
        fcitx5.enable = true;
        gtk.enable = true;
      };

      programs = {
        ghostty.enable = true;
      };
    };
  };
}
