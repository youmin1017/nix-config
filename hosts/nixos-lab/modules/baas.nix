{
  pkgs,
  config,
  ...
}:
let
  keycloak = "keycloak";
in
{
  services = {

    nginx = {
      enable = true;
      recommendedGzipSettings = true;

      virtualHosts."keycloak.local".locations."/".proxyPass =
        "http://localhost:${toString config.services.keycloak.settings.http-port}";
    };

    minio = {
      enable = true;
      rootCredentialsFile = config.sops.secrets."lab/minio/credentials".path;
      consoleAddress = ":9000";
      listenAddress = ":9001";
    };

    keycloak = {
      enable = true;
      database = {
        type = "postgresql";
        createLocally = false;
        name = keycloak;
        username = keycloak;
        passwordFile = config.sops.secrets."lab/keycloak/database/password".path;
      };
      settings = {
        hostname = "localhost";
        http-port = 30080;
        http-enabled = true;
      };
    };

    postgresql = {
      enable = true;
      authentication = ''
        #type database  DBuser  auth-method
        local all all trust
      '';
      ensureDatabases = [
        keycloak
      ];
      ensureUsers = [
        {
          name = keycloak;
          ensureDBOwnership = true;
        }
      ];
      initialScript = config.sops.templates."postgres-init.sql".path;
    };
  };

  sops.secrets = {
    "lab/minio/credentials" = { };
    "lab/keycloak/database/password" = { };
    "lab/ldap/host" = { };
    "lab/ldap/dcdomain" = { };
    "lab/ldap/ad/username" = { };
    "lab/ldap/ad/password" = { };
    "lab/postgres/password" = { };
  };

  sops.templates = {
    "postgres-init.sql".content = ''
      alter user postgres with password ${config.sops.placeholder."lab/postgres/password"};
      alter user ${keycloak} with password ${config.sops.placeholder."lab/keycloak/database/password"};
    '';
  };
}
