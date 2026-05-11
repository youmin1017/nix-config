let
  youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpjPAzjBx02LUyLps546KtLHBHVmH3JtRZLeDx+4Rjo youmin@ziling-pc";
  ziling_pc_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlJlo0COMI55lmVocFudTx8QOs1guOsnWO3vjMr4jZh root@ziling-pc";
  users = [
    ziling_pc_root
    youmin
  ];
in
{
  "youmin-password.age".publicKeys = users;
}
