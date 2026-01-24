{ config, lib, ... }:
{
  options.myHome.programs.zoxide.enable = lib.mkEnableOption "zoxide program";

  config = lib.mkIf config.myHome.programs.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = config.myHome.programs.zsh.enable;
    };
  };

}
