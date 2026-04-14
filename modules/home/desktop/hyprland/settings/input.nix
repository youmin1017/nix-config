{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = lib.mkDefault {
      follow_mouse = 2;
      natural_scroll = true;
      sensitivity = -0.2;
      touchpad = {
        natural_scroll = true;
      };
    };
  };
}
