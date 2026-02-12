{ config, lib, ... }:
{
  options.myHome.programs.hyprshot.enable = lib.mkEnableOption "hyprshot screenshot tool";

  config =
    lib.mkIf (config.myHome.desktop.hyprland.enable && config.myHome.programs.hyprshot.enable)
      {
        programs.hyprshot = {
          enable = true;
          saveLocation = "$HOME/Pictures/Screenshots";
        };
      };
}
