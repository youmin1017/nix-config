{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./autostart.nix
    ./bindings.nix
    ./input.nix
    ./looknfeel.nix
    ./rules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      monitor = [
        "DP-6,1920x1080@143.85,-1920x0,1"
        "DP-4,1920x1080@100.00,0x0,1"
        "DP-5,1920x1080@100.00,1920x-420,1,transform,3"
      ];
    };
  };
  services.hyprpolkitagent.enable = true;
}
