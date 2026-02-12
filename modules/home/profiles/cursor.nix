{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.myHome.profiles.cursor.enable = lib.mkEnableOption "Custom cursor theme configuration";

  config = lib.mkIf config.myHome.profiles.cursor.enable {
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;

      gtk.enable = true;
      hyprcursor.enable = true;
    };
  };
}
