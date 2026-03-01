{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHome.profiles.fcitx5.enable = lib.mkEnableOption "fcitx5 input method profile";

  config = lib.mkIf config.myHome.profiles.fcitx5.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          qt6Packages.fcitx5-qt
          fcitx5-rime
          rime-data
          # themes
          fcitx5-rose-pine
          fcitx5-tokyonight
        ];

        settings = {
          addons.classicui.globalSection = {
            Theme = "Tokyonight-Storm";
            Font = "DejavuSansM Nerd Font 10";
            MenuFont = "DejavuSansM Nerd Font 10";
            TrayFont = "DejavuSansM Nerd Font Bold 10";
          };

          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "rime";
          };
        };
      };
    };
  };
}
