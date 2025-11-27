{
  isDarwin,
  username,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot (
      if isDarwin then
        [
          "hosts/core/darwin.nix"
        ]
      else
        [
          "hosts/core/linux.nix"
        ]
    ))
  ];

  sops = {
    age.keyFile = config.users.users.${username}.home + "/.config/sops/age/keys.txt";
    defaultSopsFile = lib.custom.relativeToRoot "secrets/secrets.yaml";
  };

}
