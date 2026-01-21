{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixosModules = {
      hardware = ../hardware;
      locale-zh-tw = ../locale/zh-tw;
      nixos = ../nixos;
      users = ../users;
    };

    nixosConfigurations =
      let
        modules = self.nixosModules;
      in
      inputs.nixpkgs.lib.genAttrs
        [
          "ziling-pc"
        ]
        (
          host:
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ../../hosts/${host}
              inputs.agenix.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              modules.hardware
              modules.nixos
              modules.users

              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit self; };
                  backupFileExtension = "backup";
                };

                nixpkgs = {
                  overlays = [
                    self.overlays.default
                    self.inputs.neovim-nightly-overlay.overlays.default
                  ];

                  config.allowUnfree = true;
                };
              }
            ];

            specialArgs = { inherit self; };
          }
        );
  };
}
