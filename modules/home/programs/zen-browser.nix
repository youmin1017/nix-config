{
  self,
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.programs.zen-browser;
in
{
  imports = [
    self.inputs.zen-browser.homeModules.default
  ];

  options.myHome.programs.zen-browser = {
    enable = lib.mkEnableOption "zen-browser";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
    };
  };
}
