{
  config,
  ...
}:
let
  keycloak = "keycloak";
  keycloakPort = 30080;
in
{
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;

      virtualHosts."auth.wke.csie.ncnu.edu.tw" = {
        sslCertificateKey = config.sops.secrets."wke/ssl/key".path;
        sslCertificate = config.sops.secrets."wke/ssl/cert".path;
        sslTrustedCertificate = config.sops.secrets."wke/ssl/ca".path;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString keycloakPort}/";
        };
      };
    };

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
        hostname = "auth.wke.csie.ncnu.edu.tw";
        http-port = keycloakPort;
        http-enabled = true;
        proxy-headers = "xforwarded";
      };
      initialAdminPassword = "keycloakadmin";
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
    "lab/minio/credentials" = { };
    "lab/keycloak/database/password" = { };
    "lab/ldap/host" = { };
    "lab/ldap/dcdomain" = { };
    "lab/ldap/ad/username" = { };
    "lab/ldap/ad/password" = { };
    "lab/postgres/password" = { };
    "wke/ssl/key".owner = "nginx";
    "wke/ssl/cert".owner = "nginx";
    "wke/ssl/ca".owner = "nginx";
  };

  sops.templates = {
    "postgres-init.sql" = {
      owner = "postgres";
      content = ''
        alter user postgres with password '${config.sops.placeholder."lab/postgres/password"}';
        alter user ${keycloak} with password '${config.sops.placeholder."lab/keycloak/database/password"}';
      '';
    };
  };
}
