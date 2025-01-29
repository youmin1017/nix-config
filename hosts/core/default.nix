{
  isDarwin,
  username,
  inputs,
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

  home-manager = {
    extraSpecialArgs = {
      inherit inputs isDarwin;
      utils = import ./utils.nix { inherit isDarwin username; };
    };
    users.${username}.imports = [
      (lib.custom.relativeToRoot "home/home.nix")
    ];
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

}
