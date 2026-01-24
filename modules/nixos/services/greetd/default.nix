{
  config,
  lib,
  pkgs,
  ...
}:
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
  };

  config = lib.mkIf config.myNixOS.services.greetd.enable {
    # 1. Enable ReGreet and configure its look/feel
    programs.regreet = {
      enable = true;
      # Optional: Fix for theming issues if ReGreet cannot find the cursor/theme
      # theme = { name = "Adwaita-dark"; package = pkgs.gnome.gnome-themes-extra; };
      # cursorTheme = { name = "Adwaita"; package = pkgs.gnome.adwaita-icon-theme; };

      settings = {
        background = {
          # path = "/path/to/your/wallpaper.png";
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
          # ReGreet must run inside a Wayland compositor. We use Cage.
          command = "${pkgs.cage}/bin/cage -s -- ${lib.getExe config.programs.regreet.package}";
          user = "greeter";
        };
      }
      // (lib.optionalAttrs (config.myNixOS.services.greetd.autoLogin != null) {
        initial_session = {
          command = config.myNixOS.services.greetd.session;
          user = config.myNixOS.services.greetd.autoLogin;
        };
      });
    };

    # 4. Security / PAM (Unchanged)
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      fprintAuth = false;
      gnupg.enable = true;
      kwallet.enable = true;
    };
  };
}
