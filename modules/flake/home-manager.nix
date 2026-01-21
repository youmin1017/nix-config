# { self, ... }:
{
  flake = {
    # homeConfigurations = {
    #   "youmin@ziling-pc" = self.inputs.home-manager.lib.homeManagerConfiguration {
    #     extraSpecialArgs = { inherit self; };

    #     modules = [
    #     ];

    #     pkgs = import self.inputs.nixpkgs {
    #       system = "x86_64-linux";
    #       config.allowUnfree = true;

    #       overlays = [
    #         self.overlays.default
    #       ];
    #     };
    #   };
    # };

    homeModules = {
      default = ../home;
      youmin = ../../homes/youmin;
    };
  };
}
