{ config, ... }:
{
  services.zitadel = {
    enable = true;

    tlsMode = "external"; # Use "external" to use the TLS certificate from Traefik
    masterKeyFile = config.sops.secrets."hosts/nixos-dev/zitadel/master_key".path;

    settings = {
      Port = 11000;
      Database.postgres = {
        Host = "localhost";
        Port = 5432;
        Database = "zitadel";
      };
    };

    extraSettingsPaths = [
      config.sops.templates."zitadel_settings.yaml".path
    ];
    extraStepsPaths = [
      config.sops.templates."zitadel_steps.yaml".path
    ];
  };

  sops.templates."zitadel_settings.yaml" = {
    owner = "zitadel";
    content = ''
      ExternalDomain: ${config.sops.placeholder."hosts/nixos-dev/zitadel/external_domain"}
      ExternalSecure: true
      Database:
        postgres:
          User:
            Username: zitadel
            Password: ${config.sops.placeholder."hosts/nixos-dev/postgresql/users/zitadel/password"}
            SSL:
              Mode: disable
          Admin:
            Username: postgres
            Password: ${config.sops.placeholder."hosts/nixos-dev/postgresql/users/postgres/password"}
            SSL:
              Mode: disable
    '';
  };
  sops.templates."zitadel_steps.yaml" = {
    owner = "zitadel";
    content = ''
      FirstInstance:
        Org:
          Name: ICM
          Human:
            UserName: ${config.sops.placeholder."hosts/nixos-dev/zitadel/org/ICM/username"}
            Password: ${config.sops.placeholder."hosts/nixos-dev/zitadel/org/ICM/password"}
            DisplayName: ICM Admin
            FirstName: ICM
            LastName: Admin
            PasswordChangeRequired: false
    '';
  };
  sops.secrets."hosts/nixos-dev/host" = { };
  sops.secrets."hosts/nixos-dev/postgresql/users/zitadel/password" = { };
  sops.secrets."hosts/nixos-dev/postgresql/users/postgres/password" = { };
  sops.secrets."hosts/nixos-dev/zitadel/org/ICM/username" = { };
  sops.secrets."hosts/nixos-dev/zitadel/org/ICM/password" = { };
  sops.secrets."hosts/nixos-dev/zitadel/external_domain" = { };
  sops.secrets."hosts/nixos-dev/zitadel/master_key".owner = "zitadel";
}
