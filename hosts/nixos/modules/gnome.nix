{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
    ]
  );

  environment.systemPackages = with pkgs; [
    ddcutil
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.allow-locked-remote-desktop
    gnomeExtensions.kimpanel
  ];
}
