{
  self,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    self.homeModules.default
  ];

  config = lib.mkMerge [
    {
      home.username = "youmin";
      home.stateVersion = "25.11";
      nix = {
        gc = {
          automatic = true;
          options = "--delete-older-than 3d";
          persistent = true;
          randomizedDelaySec = "60min";
        };
      };
      myHome = {
        programs.git = {
          enable = true;
          user.name = "youmin1017";
          user.email = "youmin.main@gmail.com";
        };
      };
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      home = {
        homeDirectory = "/Users/youmin";
      };
      # myHome.youmin.desktop.macos.enable = true;
    })
    (lib.mkIf pkgs.stdenv.isLinux {
      home.homeDirectory = "/home/youmin";
    })
  ];
}
