{
  isDarwin,
  inputs,
  lib,
  ...
}:
let
  isLinux = !isDarwin;
in
{
  imports = [
    ./home.nix
    ./dotfiles
    ./core
  ]
  # Linux specific
  ++ lib.optionals isLinux [
    inputs.nix-colors.homeManagerModules.default
    inputs.vicinae.homeManagerModules.default
    ./modules/dconf.nix
    ./modules/cursor.nix
    ./modules/gtk.nix
    ./modules/omarchy.nix
    ./modules/hyprland
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/hyprpaper.nix
    ./modules/pkgs.nix
    ./modules/rofi.nix
    ./modules/waybar.nix
    ./modules/color.nix
    ./modules/vicinae.nix
    ./modules/swayosd.nix
  ];
}
