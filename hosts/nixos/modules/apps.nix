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
        google-chrome
        ghostty
        discord
        bottles
        spotify
        wl-clipboard-rs
        zed-editor
        jetbrains.datagrip
      ]
    else
      [ ];
}
