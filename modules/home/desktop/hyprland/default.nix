{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myHome.desktop.hyprland;
in
{
  options.myHome.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop environment";

    laptopMonitor = lib.mkOption {
      description = "Internal laptop monitor.";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };

    monitors = lib.mkOption {
      description = "List of external monitors.";
      default = [ ];
      type = lib.types.listOf lib.types.str;
    };
  };

  imports = [
    ./settings
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };
    xdg.configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

    home.packages = with pkgs; [
      nwg-displays
    ];

    myHome = {
      desktop.enable = true;

      profiles = {
        cursor.enable = true;
        dconf.enable = true;
        fcitx5.enable = true;
        gtk.enable = true;
      };

      programs = {
        ghostty.enable = true;
        hyprshot.enable = true;
      };

      services = {
        hypridle.enable = true;
      };
    };
  };
}
