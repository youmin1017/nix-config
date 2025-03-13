{ username, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    home = "/home/${username}";
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
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

}
