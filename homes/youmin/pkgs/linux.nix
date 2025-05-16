{
  pkgs,
  config,
  lib,
  isDarwin,
  ...
}:
lib.mkIf (!isDarwin) {
  home.packages = with pkgs; [
    trashy
    jose # A command-line utility for working with JWKs, JWTs, and JWE
  ];

  home.shellAliases = {
    trashrestore =
      lib.mkIf (!isDarwin)
        "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force";
    trashempty =
      lib.mkIf (!isDarwin)
        "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force";
  };

  programs.zsh.initContent = lib.mkOrder 1300 ''
    unset __HM_SESS_VARS_SOURCED
    . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';
}
