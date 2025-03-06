{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      rust-overlay,
      darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      username = "youmin";
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit outputs inputs username;
          isDarwin = false;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
        ];
        # ========== Extend lib with lib.custom ==========
        # NOTE: This approach allows lib.custom to propagate into hm
        # see: https://github.com/nix-community/home-manager/pull/3454
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };

      darwinConfigurations."Youmins-MacBook-Air" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit outputs inputs username;
          isDarwin = true;
        };
        modules = [
          ./hosts/darwin/configuration.nix
        ];
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };
    };
}
