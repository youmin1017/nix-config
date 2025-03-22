{
  pkgs,
  config,
  ...
}:
let
  keycloak = "keycloak";
  keycloakPort = 30080;
in
{
  services = {
    minio = {
      enable = true;
      rootCredentialsFile = config.sops.secrets."lab/minio/credentials".path;
      consoleAddress = ":9000";
      listenAddress = ":9001";
      region = "tw-1";
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
        http-relative-path = "/";
        hostname = "localhost";
        http-port = keycloakPort;
        http-enabled = true;
        proxy-headers = "xforwarded";
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
        "hasura"
      ];
      ensureUsers = [
        {
          name = keycloak;
          ensureDBOwnership = true;
        }
        {
          name = "hasura";
          ensureDBOwnership = true;
        }
      ];
      initialScript = config.sops.templates."postgres-init.sql".path;
    };
  };

  sops.secrets = {
    "lab/minio/credentials" = {
      neededForUsers = true;
      owner = "minio";
    };
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
