{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Extensions
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.nm-applet.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    rofi
    swww
    wlogout
  ];

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
