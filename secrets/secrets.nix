let
  youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpjPAzjBx02LUyLps546KtLHBHVmH3JtRZLeDx+4Rjo youmin@ziling-pc";
  ziling_pc_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlJlo0COMI55lmVocFudTx8QOs1guOsnWO3vjMr4jZh root@ziling-pc";
  users = [
    ziling_pc_root
    youmin
  ];

  # mtaxi
  mtaxi_youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF56IcdHwdJB0wdM6SFkXTv5+Khw6EdDu8sOHWNbHg9V youmin@mtaxi";
  mtaxi_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKnXRMXPRVx6zdMJb4/xdPRv+J1KriU3ZUe/T1V08Im root@mtaxi";
  mtaxi_users = [
    mtaxi_root
    mtaxi_youmin
  ];
in
{
  "youmin-password.age".publicKeys = users;
  "mtaxi-youmin-password.age".publicKeys = mtaxi_users;
}
