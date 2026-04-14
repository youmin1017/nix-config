{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.dev.rust;
in
{
  options.myHome.dev.rust = {
    enable = lib.mkEnableOption "Rust development environment configuration.";
    package = lib.mkOption {
      type = lib.types.package;
      inherit (pkgs.rust-bin.stable.latest) default;
      description = "The Rust toolchain package to use.";
    };
    rust-analyzer = lib.mkPackageOption pkgs "rust-analyzer" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
      cfg.rust-analyzer
    ];

    myHome = {
      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.lang.rust"
      ];
    };
  };
}
