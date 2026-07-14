{
  self,
  impurity,
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.desktop.hyprland;
in
{
  options.myHome.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop environment";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = false;
      package = null;
      portalPackage = null;
    };

    xdg.configFile = {
      "hypr".source = impurity.link "${self}/dotfiles/hypr";
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
        hyprshot.enable = true;
      };
    };
  };
}
