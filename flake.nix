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
    impurity.url = "github:outfoxxed/impurity.nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    # Hyprland Plugins
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    # utilities
    nix-colors.url = "github:misterio77/nix-colors";
    vicinae.url = "github:vicinaehq/vicinae"; # App Launcher

    # Quick Shell Config
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }:
    let
      hosts = import ./hosts { inherit self; };
    in
    {
      inherit (hosts) nixosConfigurations;
      inherit (hosts) darwinConfigurations;
    };
}
