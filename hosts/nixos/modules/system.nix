{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    material-design-icons
    font-awesome
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "DejaVuSansMono"
      ];
    })
  ];

}
