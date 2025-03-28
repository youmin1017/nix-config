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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
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

      nixosConfigurations."nixos-lab" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit outputs inputs username;
          isDarwin = false;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-lab/configuration.nix
        ];
        lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      };

      nixosConfigurations."nixos-baas" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit outputs inputs username;
          isDarwin = false;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-baas/configuration.nix
        ];
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
