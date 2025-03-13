{
  isDarwin,
  username,
  inputs,
  outputs,
  config,
  lib,
  ...
}:
let
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    inputs.sops-nix.nixosModules.sops

    (map lib.custom.relativeToRoot (
      if isDarwin then
        [
          "hosts/core/darwin.nix"
        ]
      else
        [
          "hosts/core/nixos.nix"
        ]
    ))
  ];

  nixpkgs.overlays = [ outputs.overlays.default ];

  sops = {
    age.keyFile = config.users.users.${username}.home + "/.config/sops/age/keys.txt";
    defaultSopsFile = lib.custom.relativeToRoot "secrets/secrets.yaml";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit outputs inputs isDarwin;
      utils = import ./utils.nix { inherit isDarwin username; };
    };
    users.${username}.imports = [
      (lib.custom.relativeToRoot "home/home.nix")
    ];
    # useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

}
