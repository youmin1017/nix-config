{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.programs.jujutsu;
in
{
  options.myHome.programs.jujutsu.enable = lib.mkEnableOption "Enable jujutsu program";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jujutsu
    ];

    xdg.configFile = {
      "jj/config.toml".text = ''
        [user]
        email = "${config.myHome.programs.git.user.email}"
        name = "${config.myHome.programs.git.user.name}"
      '';
    };
  };
}
