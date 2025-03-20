{
  config,
  username,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  users.mutableUsers = false;
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
    hashedPasswordFile = config.sops.secrets."personal/password".path;
    openssh.authorizedKeys.keyFiles = [
      config.sops.secrets."personal/ssh/publicKeys".path
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

  sops.secrets = {
    "personal/password" = { };
    "personal/ssh/publicKeys" = { };
  };
}
