{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHome.services.udiskie.enable = lib.mkEnableOption "udiskie home service";

  config = lib.mkIf config.myHome.services.udiskie.enable {
    services.udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.nautilus}/bin/nautilus";
        };
      };
    };
  };
}
