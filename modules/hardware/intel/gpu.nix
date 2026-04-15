{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHardware.intel.gpu.enable = lib.mkEnableOption "Intel GPU configuration.";
  config = lib.mkIf config.myHardware.intel.gpu.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt # Hardware video acceleration for newer GPUs (NixOS >24.05)
        intel-media-driver # VAAPI driver for Broadwell+ iGPUs
      ];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Force iHD driver (intel-media-driver)
    };
  };
}
