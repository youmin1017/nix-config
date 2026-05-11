{
  self,
  pkgs,
  lib,
  ...
}:

let
  plugins = [
    self.inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
  ];

  mkEntry =
    entry: if lib.types.package.check entry then "${entry}/lib/lib${entry.pname}.so" else entry;

  pluginsLua = lib.concatStringsSep "\n" (map (p: ''"${mkEntry p}",'') plugins);
in
{
  xdg.configFile = {
    "hyprland-plugins.lua".text = ''
      local plugins = {
        ${pluginsLua}
      }
    '';
  };
}
