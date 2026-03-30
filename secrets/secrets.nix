let
  youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHICTFputeCwhNc27FYXpnZ3cZdZaeb/7inmbHTUeSw3 youmin@nixos";
  devRoot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiClIxpAzFBy+XnpQMmUvuaIvZqTqR7fWQ5erAF3iAl root@nixos";

  devUsers = [
    devRoot
    youmin
  ];
in
{
  "wke-ssl.cert.age".publicKeys = devUsers;
  "wke-ssl.key.age".publicKeys = devUsers;
  "headscale-db-password.age".publicKeys = devUsers;
  "headscale-authkey.age".publicKeys = devUsers;
  "keycloak-db-password.age".publicKeys = devUsers;
  "minio-root-credentials.age".publicKeys = devUsers;
  "minio-console.age".publicKeys = devUsers;
  "user-youmin-password.age".publicKeys = devUsers;
  "syncwke-secret.age".publicKeys = devUsers;
}
