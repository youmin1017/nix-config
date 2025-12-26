{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blueberry
    pavucontrol
    wget
    trashy
  ];
}
