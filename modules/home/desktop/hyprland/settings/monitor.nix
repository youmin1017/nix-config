{
  config,
  lib,
  ...
}:
{

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,auto"
    ]
    ++ config.myHome.desktop.hyprland.monitors
    ++ lib.lists.optional (
      config.myHome.desktop.hyprland.laptopMonitor != null
    ) config.myHome.desktop.hyprland.laptopMonitor;
  };
}
