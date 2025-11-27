{ self }:
let
  inherit (self) inputs outputs;
  inherit (inputs)
    nixpkgs
    darwin
    home-manager
    ;

  username = "youmin";

  homeDir = self + /homes;
  hm-nixos = home-manager.nixosModules.home-manager;
  hm-darwin = home-manager.darwinModules.home-manager;

  mkLinuxHost =
    { name, config }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit outputs inputs username;
        isDarwin = false;
      };
      system = "x86_64-linux";
      lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
      modules = [
        {
          # Hostname
          networking.hostName = name;

          # Impurity
          imports = [ inputs.impurity.nixosModules.impurity ];
          impurity.configRoot = self;
          impurity.enable = true;
        }
        config
        homeDir
        hm-nixos
      ];
    };
in
{

  nixosConfigurations =
    let
      hosts = [
        {
          name = "nixos-lab";
          config = ./nixos-lab/configuration.nix;
        }
        {
          name = "nixos-dev";
          config = ./nixos-dev/configuration.nix;
        }
      ];
    in
    builtins.listToAttrs (
      map (host: {
        inherit (host) name;
        value = mkLinuxHost host;
      }) hosts
    );

  darwinConfigurations."Youmins-MacBook-Air" = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = {
      inherit outputs inputs username;
      isDarwin = true;
    };
    modules = [
      ./darwin/configuration.nix
      homeDir
      hm-darwin
      {
        # Impurity
        imports = [ inputs.impurity.nixosModules.impurity ];
        impurity.configRoot = self;
        impurity.enable = true;
      }
    ];
    lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
  };
}
