{
  inputs,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    if config.hardware.graphics.enable then
      [
        # browsers
        inputs.zen-browser.packages."x86_64-linux".default # beta
        microsoft-edge
        brave

        (bottles.override { removeWarningPopup = true; })
        bibata-cursors
        discord
        ghostty
        onlyoffice-desktopeditors
        prismlauncher
        remmina
        spotify
        teams-for-linux
        vlc # media player
        thunderbird # email client
        telegram-desktop
        wl-clipboard

        # editors
        jetbrains.datagrip
        jetbrains.goland
        zed-editor
      ]
    else
      [ ];

  programs.steam.enable = true;
}
