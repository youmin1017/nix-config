{
  lib,
  config,
  ...
}:
{
  options.myHome.programs.noctalia.enable = lib.mkEnableOption "noctalia shell program module";

  config = lib.mkIf config.myHome.programs.noctalia.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings = {
        bar = {
          density = "compact";
          position = "top";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            center = [
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "WiFi";
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "ScreenRecorder";
              }
              {
                id = "SystemMonitor";
                showCpuUsage = true;
                showCpuTemp = true;
                showMemoryUsage = true;
                showDiskUsage = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Catppuccin";
        ui = {
          fontDefault = "DejaVu Sans";
          fontFixed = "DejaVuSansM Nerd Font Mono";
        };
        general = {
          avatarImage = "/home/drfoobar/.face";
          radiusRatio = 0.2;
        };
        location = {
          name = "Puli, Nantou";
          monthBeforeDay = true;
        };
      };
    };
  };
}
