{
  lib,
  config,
  ...
}:
{
  options.myHome.profiles.gtk.enable = lib.mkEnableOption "GTK profile configuration";

  config = lib.mkIf config.myHome.profiles.gtk.enable {
    gtk = {
      enable = true;
      colorScheme = "dark";
    };
  };
}
