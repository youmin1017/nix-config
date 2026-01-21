{ config, lib, ... }:
{
  imports = [
    ./hyprland
  ];

  options.myHome.desktop.enable = lib.mkOption {
    default =
      config.myHome.desktop.gnome.enable or config.myHome.desktop.hyprland.enable
        or config.myHome.desktop.kde.enable;
    description = "Desktop environment configuration.";
    type = lib.types.bool;
  };
}
