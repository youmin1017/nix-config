{
  config,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    if config.hardware.graphics.enable then
      [
        inputs.zen-browser.packages.${system}.default
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
