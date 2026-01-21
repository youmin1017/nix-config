# { self, ... }:
{
  flake.overlays = {
    default =
      _final: prev:
      # let
      #   nixos-stable = import self.inputs.nixpkgs-stable {
      #     config.allowUnfree = true;
      #     inherit (prev) system;
      #   };
      # in
      {

      };
  };
}
