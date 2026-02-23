{
  config,
  lib,
  ...
}:
{
  options.myNixOS.programs.nix.enable = lib.mkEnableOption "sane nix configuration";

  config = lib.mkIf config.myNixOS.programs.nix.enable {
    nix = {
      channel.enable = false;
      distributedBuilds = true;

      gc = {
        automatic = true;

        options = "--delete-older-than 7d";

        persistent = true;
        randomizedDelaySec = "60min";
      };

      extraOptions = ''
        min-free = ${toString (1 * 1024 * 1024 * 1024)}   # 1 GiB
        max-free = ${toString (5 * 1024 * 1024 * 1024)}   # 5 GiB
      '';

      optimise = {
        automatic = true;
        persistent = true;
        randomizedDelaySec = "60min";
      };

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        substituters = [
          # "https://mirrors.cernet.edu.cn/nix-channels/store"
          "https://hyprland.cachix.org"
          "https://vicinae.cachix.org"
          "https://nix-community.cachix.org"
        ];

        trusted-substituters = [ "https://hyprland.cachix.org" ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };

    programs.nix-ld.enable = true;
  };
}
