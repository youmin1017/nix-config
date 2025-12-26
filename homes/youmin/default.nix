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
    inputs.noctalia.homeModules.default
    ./modules/dconf.nix
    ./modules/cursor.nix
    ./modules/gtk.nix
    ./modules/omarchy.nix
    ./modules/fcitx5.nix
    ./modules/hyprland
    # ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/hyprpaper.nix
    ./modules/hyprshot.nix
    ./modules/pkgs.nix
    ./modules/color.nix
    ./modules/udiskie.nix

    # status bar
    # ./modules/waybar.nix
    ./modules/noctalia.nix

    # launcher
    # ./modules/rofi.nix
    ./modules/vicinae.nix

    # osd
    # ./modules/swayosd.nix
  ];
}
