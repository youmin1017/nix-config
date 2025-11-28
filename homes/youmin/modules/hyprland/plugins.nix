{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland.plugins = [
    # Wait this CI passing: https://github.com/Duckonaut/split-monitor-workspaces/actions/workflows/main.yml
    # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
  ];
}
