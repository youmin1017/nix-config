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
      jose # A command-line utility for working with JWKs, JWTs, and JWE
    ]
  );

  home.shellAliases = {
    trashrestore =
      lib.mkIf (!isDarwin)
        "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force";
    trashempty =
      lib.mkIf (!isDarwin)
        "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force";
  };
}
