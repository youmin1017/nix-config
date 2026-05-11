{ lib, ... }:
{
  options.myUsers =
    let
      mkUser = user: {
        enable = lib.mkEnableOption "${user}.";

        hashedPasswordFile = lib.mkOption {
          default = null;
          description = "The full path to a file that contains the hash of the user’s password for user ${user}.";
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
