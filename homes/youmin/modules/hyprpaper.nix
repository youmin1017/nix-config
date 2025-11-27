{ config, lib, ... }:
let
  inherit ((import (lib.custom.relativeToRoot "lib/wallpaper_path.nix") config)) wallpaper_path;
in
{
  home.file = {
    "Pictures/Wallpapers" = {
      source = lib.custom.relativeToRoot "assets/wallpapers";
      recursive = true;
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaper_path
      ];
      wallpaper = [
        ",${wallpaper_path}"
      ];
    };
  };
}
