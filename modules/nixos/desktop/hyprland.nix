{
  self,
  config,
  pkgs,
  lib,
  ...
}:
{
  options.myNixOS.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop environment";
  };

  config = lib.mkIf config.myNixOS.desktop.hyprland.enable {
    home-manager.sharedModules = [
      {
        myHome.desktop.hyprland = {
          enable = true;
        };
      }
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = self.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        self.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Polkit agent for Hyprland
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    system.nixos.tags = [ "hyprland" ];
    myNixOS.desktop.enable = true;
  };
}
