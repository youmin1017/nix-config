{
  pkgs,
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
}
