{
  inputs,
  pkgs,
  ...
}:
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  environment.systemPackages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    networkmanagerapplet
    rofi
    swww
    wlogout

    # sound
    blueberry
    pavucontrol

    # system apps
    kdePackages.dolphin
  ];

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  systemd.user.services.waybar.path = [
    "/run/current-system/sw"
  ];
}
