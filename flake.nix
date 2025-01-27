{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      username = "youmin";
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username;
          isDarwin = false;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
        # ========== Extend lib with lib.custom ==========
        # NOTE: This approach allows lib.custom to propagate into hm
        # see: https://github.com/nix-community/home-manager/pull/3454
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };
    };
}
