{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    # Keyboard
    keyboard.qmk.enable = true;
    ## Uinput
    uinput.enable = true;
  };
  boot.kernelModules = [ "uinput" ];
  users.groups.uinput = { };
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  # disable here, config is moved to home-manager modules
  # i18n.inputMethod = {
  #   type = "fcitx5";
  #   enable = false;
  #   fcitx5 = {
  #     waylandFrontend = true;
  #     addons = with pkgs; [
  #       fcitx5-gtk
  #       qt6Packages.fcitx5-qt
  #       fcitx5-rime
  #       rime-data
  #     ];
  #   };
  # };

  fonts.packages = with pkgs; [
    corefonts
    material-design-icons
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.dejavu-sans-mono
  ];
}
