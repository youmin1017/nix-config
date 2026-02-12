{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.myHome.profiles.dconf.enable = lib.mkEnableOption "dconf profile configuration";

  config = lib.mkIf (pkgs.stdenv.isLinux && config.myHome.profiles.dconf.enable) {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-key-theme = "Emacs";
      };
    };
  };
}
