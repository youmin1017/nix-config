{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    if config.hardware.graphics.enable then
      [
        microsoft-edge
        ghostty
        discord
        # bottles
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
