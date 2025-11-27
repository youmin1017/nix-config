{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blueberry
    pavucontrol
    hyprshot
  ];
}
