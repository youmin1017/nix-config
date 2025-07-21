{
  isDarwin,
  username,
  config,
  outputs,
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

  nixpkgs.overlays = [ outputs.overlays.default ];

  sops = {
    age.keyFile = config.users.users.${username}.home + "/.config/sops/age/keys.txt";
    defaultSopsFile = lib.custom.relativeToRoot "secrets/secrets.yaml";
  };

}
