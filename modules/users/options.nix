{ lib, ... }:
{
  options.myUsers =
    let
      mkUser = user: {
        enable = lib.mkEnableOption "${user}.";

        password = lib.mkOption {
          default = null;
          description = "the hashed password for user ${user}.";
          type = lib.types.nullOr lib.types.str;
        };
      };
    in
    {
      defaultGroups = lib.mkOption {
        description = "Default groups for desktop users.";
        default = [
          "networkmanager"
          "wheel"
          "docker"
        ];
      };

      root.enable = lib.mkEnableOption "root user configuration." // {
        default = true;
      };
      youmin = mkUser "youmin";
    };
}
