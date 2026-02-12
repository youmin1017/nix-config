{
  lib,
  config,
  ...
}:
{
  options.myHome.services.hypridle.enable = lib.mkEnableOption "hypridle home service";

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.services.hypridle.enable) {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "noctalia-shell ipc call lockScreen lock";
          }
          {
            timeout = 330;
            on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend";
            # on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
        ];
      };
    };
  };
}
