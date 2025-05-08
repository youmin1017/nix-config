{
  pkgs,
  lib,
  isDarwin,
  ...
}:
{
  # Linux-specific packages
  home.packages = lib.mkIf (!isDarwin) (
    with pkgs;
    [
      trashy
    ]
  );
}
