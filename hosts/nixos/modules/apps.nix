{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    if config.hardware.graphics.enable then
      [
        inputs.zen-browser.packages."x86_64-linux".default # beta
        microsoft-edge
        teams-for-linux
        ghostty
        discord
        (bottles.override { removeWarningPopup = true; })
        spotify
        remmina
        wl-clipboard
        zed-editor
        jetbrains.datagrip
        jetbrains.goland
        bibata-cursors
        thunderbird # email client
        vlc # media player

        # office
        onlyoffice-desktopeditors

        # minecraft
        prismlauncher
      ]
    else
      [ ];
}
