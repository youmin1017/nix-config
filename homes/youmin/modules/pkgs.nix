{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blueberry
    pavucontrol
    brightnessctl
    wget
  ];
}
