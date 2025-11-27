{
  pkgs,
  lib,
  isDarwin,
  ...
}:
lib.mkIf (isDarwin) {
  home.packages = with pkgs; [
    docker
  ];
}
