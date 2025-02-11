{ config, utils, ... }:
let
  dotfile = "ideavimrc";
in
{
  home.file.".${dotfile}" = {
    source = config.lib.file.mkOutOfStoreSymlink (utils.getDotfilePath dotfile);
  };
}
