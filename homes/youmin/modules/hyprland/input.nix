{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = lib.mkDefault {
      follow_mouse = 2;
      natural_scroll = true;
      touchpad = {
        natural_scroll = true;
      };
    };
  };
}
