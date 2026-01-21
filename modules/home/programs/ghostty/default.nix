{
  config,
  lib,
  ...
}:
{
  options.myHome.programs.ghostty.enable = lib.mkEnableOption "ghostty terminal emulator";

  config = lib.mkIf config.myHome.programs.ghostty.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        theme = "TokyoNight";
      };
    };
  };
}
