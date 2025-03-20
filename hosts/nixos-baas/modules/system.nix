{ lib, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Virtualization
  # virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  # # Only In WKE
  fileSystems."/mnt/syncwke/EAS_RW" = lib.mkIf true {
    device = "//syncwke.csie.ncnu.edu.tw/EAS_RW";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/syncwke-secrets" ];
  };

  fileSystems."/mnt/syncwke/home" = lib.mkIf true {
    device = "//syncwke.csie.ncnu.edu.tw/home";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/syncwke-secrets" ];
  };
}
