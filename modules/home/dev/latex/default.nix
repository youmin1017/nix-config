{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.latex.enable = lib.mkEnableOption "Enable LaTeX development environment";

  config = lib.mkIf config.myHome.dev.latex.enable {
    home.packages = with pkgs; [
      (texlive.combine {
        inherit (pkgs.texlive)
          scheme-medium
          biblatex
          xecjk
          ;
      })
      texlab
    ];
  };
}
