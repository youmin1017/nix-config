{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./youmin.nix
    ./options.nix
  ];

  config = lib.mkIf (config.myUsers.root.enable or config.myUsers.youmin.enable) {
    programs.zsh.enable = true;

    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = false;
    };
  };
}
