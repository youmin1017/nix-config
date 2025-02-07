{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    gcc
    copyq
  ];

  # Keyboard
  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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
