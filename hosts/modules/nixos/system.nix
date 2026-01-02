{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable nix-ld for better compatibility with Nix packages that require FHS
  programs.nix-ld.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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

  # UDisks2 for better disk management (e.g., for GNOME Disks)
  services.udisks2.enable = true;

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
