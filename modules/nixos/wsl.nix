{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  options.myNixOS.wsl = {
    enable = lib.mkEnableOption "nixos-wsl configuration";
  };

  imports = [
    self.inputs.nixos-wsl.nixosModules.default
  ];

  config = lib.mkIf config.myNixOS.wsl.enable {
    wsl.enable = true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    environment.systemPackages = with pkgs; [
      gcc
      glib
      wget
    ];

    security = {
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };

    myNixOS = {
      profiles = {
        swap.enable = true;
      };

      services.openssh.enable = true;
    };
  };
}
