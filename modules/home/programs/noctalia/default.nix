{
  impurity,
  self,
  lib,
  config,
  ...
}:
let
  cfg = config.myHome.programs.noctalia;
in
{
  options.myHome.programs.noctalia.enable = lib.mkEnableOption "noctalia shell program module";

  imports = [
    self.inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
    };

    xdg.configFile."noctalia".source = impurity.link "${self}/dotfiles/noctalia";
  };
}
