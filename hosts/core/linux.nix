{
  config,
  username,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
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
    hashedPasswordFile = config.age.secrets."user-youmin-password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpjPAzjBx02LUyLps546KtLHBHVmH3JtRZLeDx+4Rjo youmin@ziling-pc"
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

  age.secrets = {
    "user-youmin-password".file = ../../secrets/user-youmin-password.age;
  };
}
