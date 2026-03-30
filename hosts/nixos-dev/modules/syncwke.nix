{ config, ... }:
{

  fileSystems =
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      secretPath = config.age.secrets."syncwke-secret".path;

      mountPoints = [
        "home"
        "Public"
        "EAS_RW"
      ];
    in
    builtins.listToAttrs (
      map (mountPoint: {
        name = "/mnt/syncwke/${mountPoint}";
        value = {
          device = "//syncwke.csie.ncnu.edu.tw/${mountPoint}";
          fsType = "cifs";
          options = [ "${automount_opts},credentials=${secretPath}" ];
        };
      }) mountPoints
    );

  age.secrets = {
    "syncwke-secret".file = ../../../secrets/syncwke-secret.age;
  };
}
