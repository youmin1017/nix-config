{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable { inherit (final) system config; };
    })
  ];
}
