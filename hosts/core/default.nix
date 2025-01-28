{
  isDarwin,
  username,
  inputs,
  lib,
  pkgs,
  ...
}:
{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "ALL";
          options = [
            "NOPASSWD"
          ];
        }
      ];
    }
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs isDarwin;
      utils = import ./utils.nix { inherit isDarwin username; };
    };
    users.${username} = import (lib.custom.relativeToRoot "home/home.nix");
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

}
