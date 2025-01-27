{ config, pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      gcc
      copyq
    ]
    ++ (
      if config.hardware.graphics.enable then
        [
          firefox
          ghostty
          kitty
          networkmanagerapplet
        ]
      else
        [ ]
    );
}
