{
  pkgs,
  config,
  lib,
  isDarwin,
  ...
}:
lib.mkIf (!isDarwin) {
  home.packages = with pkgs; [
    gtrash
    jose # A command-line utility for working with JWKs, JWTs, and JWE
  ];

  home.shellAliases = {
  };

  programs.zsh.initContent = lib.mkOrder 1300 ''
    unset __HM_SESS_VARS_SOURCED
    . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';
}
