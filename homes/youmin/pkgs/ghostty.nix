# { config, utils, ... }:
# {
#   # programs.ghostty = {
#   #   enable = true;
#   # };
#
#   home.file.".config/ghostty" = {
#     source = config.lib.file.mkOutOfStoreSymlink (utils.getDotfilePath "ghostty");
#   };
# }
{ }
