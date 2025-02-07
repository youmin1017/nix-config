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
      ]
    else
      [ ];
}
