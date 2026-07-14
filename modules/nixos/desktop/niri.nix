{
  config,
  lib,
  ...
}:
{
  options.myNixOS.desktop.niri = {
    enable = lib.mkEnableOption "niri desktop environment";
  };

  config = lib.mkIf config.myNixOS.desktop.niri.enable {
    home-manager.sharedModules = [
      {
        myHome.desktop.niri = {
          enable = true;
        };
      }
    ];

    programs.niri = {
      enable = true;
    };

    system.nixos.tags = [ "niri" ];
    myNixOS.desktop.enable = true;
  };
}
