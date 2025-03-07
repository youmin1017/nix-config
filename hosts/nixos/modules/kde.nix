{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    # konsole
  ];

  environment.systemPackages = with pkgs; [
    rofi-wayland
    cifs-utils
  ];

  # i18n.inputMethod.fcitx5.plasma6Support = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
}
