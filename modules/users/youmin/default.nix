{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.myUsers.youmin.enable {
    users.users.youmin = {
      description = "Youmin";
      extraGroups = config.myUsers.defaultGroups;
      hashedPassword = config.myUsers.youmin.password;
      isNormalUser = true;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmm9xWkhK9Oxt+z24eHTeWQGqhvc6O757RMUMjC8VNv youmin@nixos-lab"
      ];
      uid = 1000;
    };
  };
}
