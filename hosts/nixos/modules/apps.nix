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
        inputs.zen-browser.packages."x86_64-linux".default # beta
        microsoft-edge
        ghostty
        discord
        (bottles.override { removeWarningPopup = true; })
        spotify
        remmina
        wl-clipboard
        zed-editor
        jetbrains.datagrip
        jetbrains.goland

        libreoffice
        hunspell
      ]
    else
      [ ];
}
