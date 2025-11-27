{ lib, pkgs, ... }:
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-key-theme = "Emacs";
      };
    };
  };
}
