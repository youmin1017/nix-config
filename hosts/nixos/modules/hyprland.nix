{ pkgs, username, ... }:
{
  programs.hyprland = {
    enable = true;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (old: {
      mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    dunst # Notification daemon
    libnotify
    swww # Wallpaper
    rofi-wayland # Launcher

    # Miscellaneous
    greetd.tuigreet
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = username;
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };
}
