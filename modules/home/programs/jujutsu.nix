{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.programs.jujutsu;
in
{
  options.myHome.programs.jujutsu.enable = lib.mkEnableOption "Enable jujutsu program";

  config = lib.mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.myHome.programs.git.user.name;
          email = config.myHome.programs.git.user.email;
        };

        aliases = {
          tug = [
            "bookmark"
            "move"
            "--from"
            "heads(::@- & bookmarks())"
            "--to"
            "@-"
          ];
        };
      };
    };
  };
}
