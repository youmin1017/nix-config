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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpjPAzjBx02LUyLps546KtLHBHVmH3JtRZLeDx+4Rjo youmin@ziling-pc"
      ];
      uid = 1000;
    };
  };
}
