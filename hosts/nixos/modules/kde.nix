{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  environment.systemPackages = with pkgs; [
    rofi-wayland
  ];

  # i18n.inputMethod.fcitx5.plasma6Support = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
}
