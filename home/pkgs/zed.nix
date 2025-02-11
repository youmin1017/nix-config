{ config, utils, ... }:
let
  keymap = "zed/keymap.json";
  settings = "zed/settings.json";
in
{
  home.file.".config/${keymap}" = {
    source = config.lib.file.mkOutOfStoreSymlink (utils.getDotfilePath keymap);
  };

  home.file.".config/${settings}" = {
    source = config.lib.file.mkOutOfStoreSymlink (utils.getDotfilePath settings);
  };
}
