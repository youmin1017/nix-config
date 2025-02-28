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
        bottles
        spotify
        remmina
        wl-clipboard-rs
        zed-editor
        jetbrains.datagrip
      ]
    else
      [ ];
}
