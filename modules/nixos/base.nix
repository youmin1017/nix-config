{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  options.myNixOS.base = {
    enable = lib.mkEnableOption "base system configuration";
  };

  config = lib.mkIf config.myNixOS.base.enable {
    environment = {
      etc."nixos".source = self;

      systemPackages = with pkgs; [
        gcc
        glib
        wget
      ];

      variables = {
        inherit (config.myNixOS) FLAKE;
        NH_FLAKE = config.myNixOS.FLAKE;
      };
    };

    fonts.packages = with pkgs; [
      corefonts
      material-design-icons
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      ubuntu-sans
      font-awesome
      nerd-fonts.dejavu-sans-mono
    ];

    hardware = {
      keyboard.qmk.enable = true;
    };

    programs = {
      dconf.enable = true; # Needed for home-manager

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };

      git.enable = true;
      nh.enable = true;
    };

    networking.networkmanager.enable = true;

    security = {
      polkit.enable = true;

      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };

    services = {
      fwupd.enable = true;

      logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
      };

      udev.packages = [ pkgs.headsetcontrol ];
      usbmuxd.enable = true;
    };

    system.configurationRevision = self.rev or self.dirtyRev or null;

    myNixOS = {
      profiles = {
        bluetooth.enable = true;
        swap.enable = true;
      };

      programs = { };

      services.openssh.enable = true;
    };
  };
}
