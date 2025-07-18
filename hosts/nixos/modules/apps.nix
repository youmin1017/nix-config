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
        (bottles.override { removeWarningPopup = true; })
        bibata-cursors
        discord
        ghostty
        hoppscotch
        jetbrains.datagrip
        jetbrains.goland
        microsoft-edge
        onlyoffice-desktopeditors
        prismlauncher
        remmina
        spotify
        teams-for-linux
        vlc # media player
        thunderbird # email client
        wl-clipboard
        zed-editor
      ]
    else
      [ ];
}
