{
  self,
  impurity,
  config,
  lib,
  ...
}:
{
  options.myHome.programs.zed.enable = lib.mkEnableOption "zed screenshot tool";

  config = lib.mkIf config.myHome.programs.zed.enable {
    programs.zed-editor = {
      enable = true;
    };

    xdg.configFile =
      lib.genAttrs
        [
          "zed/settings.json"
          "zed/keymap.json"
        ]
        (name: {
          source = impurity.link "${self}/dotfiles/${name}";
        });
  };
}
