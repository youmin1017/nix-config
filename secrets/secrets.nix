let
  youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpjPAzjBx02LUyLps546KtLHBHVmH3JtRZLeDx+4Rjo youmin@ziling-pc";
  # users = [ youmin ];
in
{
  "youmin-password.age".publicKeys = [ youmin ];
}
