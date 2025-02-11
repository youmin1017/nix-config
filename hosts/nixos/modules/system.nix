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

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      rime-data
    ];
  };

  fonts.packages = with pkgs; [
    material-design-icons
    noto-fonts-cjk-sans
    font-awesome
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "DejaVuSansMono"
      ];
    })
  ];

}
