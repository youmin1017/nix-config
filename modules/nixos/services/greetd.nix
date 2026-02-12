{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.services.greetd;
in
{
  options.myNixOS.services.greetd = {
    enable = lib.mkEnableOption "greetd display manager";

    autoLogin = lib.mkOption {
      description = "User to autologin.";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };

    session = lib.mkOption {
      description = "Default command to execute on login (used for auto-login only).";
      default = lib.getExe config.programs.hyprland.package;
      type = lib.types.str;
    };

    defaultSession = lib.mkOption {
      description = "Default greeter session command.";
      default = "${pkgs.cage}/bin/cage -s -m last -- ${lib.getExe config.programs.regreet.package}";
      defaultText = lib.literalExpression ''"''${pkgs.cage}/bin/cage -s -m last -- ''${lib.getExe config.programs.regreet.package}"'';
      type = lib.types.str;
    };

    greeterUser = lib.mkOption {
      description = "User to run the greeter as.";
      default = "greeter";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    # 1. Enable ReGreet and configure its look/feel
    programs.regreet = {
      enable = true;
      settings = {
        background = {
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

    # 2. Add Cage to system packages (required to run ReGreet)
    environment.systemPackages = with pkgs; [ cage ];

    # 3. Configure Greetd
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = cfg.defaultSession;
          user = cfg.greeterUser;
        };
      }
      // lib.optionalAttrs (cfg.autoLogin != null) {
        initial_session = {
          command = cfg.session;
          user = cfg.autoLogin;
        };
      };
    };

    # 4. Security / PAM
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      fprintAuth = false;
      gnupg.enable = true;
      kwallet.enable = true;
    };
  };
}
