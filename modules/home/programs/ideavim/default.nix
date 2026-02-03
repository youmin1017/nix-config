{
  self,
  impurity,
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.programs.ideavim;
in
{
  options.myHome.programs.ideavim.enable = lib.mkEnableOption "IdeaVim plugin for JetBrains IDEs";

  config = lib.mkIf cfg.enable {
    xdg.configFile =
      lib.genAttrs
        [
          "ideavim"
        ]
        (name: {
          source = impurity.link "${self}/dotfiles/${name}";
        });
  };
}
