config:
let
  cfg = config.omarchy;
  wallpapers = {
    "tokyo-night" = [
      "1.png"
    ];
  };

  wallpaper_path =
    if
      (cfg.theme == "generated_light" || cfg.theme == "generated_dark")
      || (cfg.theme_overrides.wallpaper_path != null)
    then
      toString cfg.theme_overrides.wallpaper_path
    else
      let
        selected_wallpaper = builtins.elemAt wallpapers.${cfg.theme} 0;
      in
      "~/Pictures/Wallpapers/${selected_wallpaper}";
in
{
  inherit wallpaper_path;
}
