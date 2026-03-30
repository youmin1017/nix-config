{ config, ... }:
{
  services.keycloak = {
    enable = true;
    database = {
      type = "postgresql";
      createLocally = true;
      name = "keycloak";
      username = "keycloak";
      passwordFile = config.age.secrets."keycloak-db-password".path;
    };
    settings = {
      http-relative-path = "/";
      hostname = "auth.wke.csie.ncnu.edu.tw";
      http-port = 13000;
      http-enabled = true;
      proxy-headers = "xforwarded";
    };
    initialAdminPassword = "keycloakadmin";
  };

  # sops.secrets."hosts/nixos-dev/postgresql/users/keycloak/password" = { };
  age.secrets = {
    "keycloak-db-password" = {
      file = ../../../secrets/keycloak-db-password.age;
    };
  };
}
