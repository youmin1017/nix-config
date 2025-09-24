{ inputs, pkgs, ... }:
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
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    networkmanagerapplet
    rofi
    swww
    wlogout

    # sound
    blueberry
    pavucontrol
  ];

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
