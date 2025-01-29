{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
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
        ];
        # ========== Extend lib with lib.custom ==========
        # NOTE: This approach allows lib.custom to propagate into hm
        # see: https://github.com/nix-community/home-manager/pull/3454
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };

      darwinConfigurations."Youmins-MacBook-Air" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs username;
          isDarwin = true;
        };
        modules = [
          ./hosts/darwin/configuration.nix
        ];
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };
    };
}
