{ self, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      self.inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];
    settings = {
      plugin = {
        split-monitor-workspaces = {
          keep_focused = true;
        };
      };
    };
  };
}
