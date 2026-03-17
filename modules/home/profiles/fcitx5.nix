{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myHome.profiles.fcitx5;

  onionRimeFiles = pkgs.stdenv.mkDerivation {
    name = "onion-rime-files";

    src = pkgs.fetchFromGitHub {
      owner = "oniondelta";
      repo = "Onion_Rime_Files";
      rev = "fd103d0a62ea123cc7b71ec2dadfff9ca52bd4cc"; # release_20260304
      hash = "sha256-GcdC0ebtX5fTWBZ3/DhDZ6DWD5F3nOJbwDizVQoauGA=";
    };

    buildInputs = [ pkgs.python3 ];

    buildPhase = ''
      python3 sort_rime_file.py
    '';

    installPhase = ''
      mkdir -p $out
      cp -r 電腦RIME方案_*/注音洋蔥mixin版_*/* $out/
    '';
  };
in
{
  options.myHome.profiles.fcitx5.enable = lib.mkEnableOption "fcitx5 input method profile";

  config = lib.mkIf cfg.enable {
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

    # 將洋蔥方案檔案同步到使用者的 RIME 配置目錄，確保使用者具有讀寫權限 (u+rwX)
    home.activation.setupOnionRime = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # 若你使用的是 Fcitx5，路徑通常為 ~/.local/share/fcitx5/rime
      # 若你使用的是 IBus，請將路徑改為 ~/.config/ibus/rime
      RIME_DIR="$HOME/.local/share/fcitx5/rime"

      mkdir -p "$RIME_DIR"

      # 將整理好的洋蔥方案檔案同步過去，並確保使用者具有讀寫權限 (u+rwX)
      # 使用 rsync 也可以避免覆蓋掉你平常累積的 userdb (個人詞庫)
      ${pkgs.rsync}/bin/rsync -a --no-perms --chmod=u+rwX ${onionRimeFiles}/ "$RIME_DIR/"
    '';
  };
}
