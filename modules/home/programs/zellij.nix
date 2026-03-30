{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.programs.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf config.myHome.programs.zellij.enable {
    myHome.programs.zoxide.enable = true;

    home.packages = with pkgs; [
      wl-clipboard
      fzf
      zoxide
    ];

    programs.zellij = {
      enable = true;
      # 不用 enableBashIntegration / enableZshIntegration
      # 因為預設會 auto-attach，行為跟 tmux 不同，建議手動控制
    };

    # Zellij config
    xdg.configFile."zellij/config.kdl".text = ''
      // UI
      pane_frames true
      simplified_ui false

      // Theme
      theme "rose-pine"

      // Mouse
      mouse_mode true

      // Clipboard — 直接用 wl-copy，繞過 OSC 52
      // 這解決了 tmux popup clipboard 的根本問題
      copy_command "wl-copy"
      copy_on_select true

      // Session
      session_serialization true
      pane_viewport_serialization true

      keybinds clear-defaults=true {

        // ── Normal mode ──────────────────────────────────────────
        normal {
          // 進入 locked mode（類似 tmux prefix，但 zellij 用 mode 切換）
          bind "Ctrl a" { SwitchToMode "tmux"; }

          // 快速切 pane（不需要 prefix）
          bind "Alt h" { MoveFocus "Left"; }
          bind "Alt l" { MoveFocus "Right"; }
          bind "Alt j" { MoveFocus "Down"; }
          bind "Alt k" { MoveFocus "Up"; }

          // 快速切 tab
          bind "Alt n" { GoToNextTab; }
          bind "Alt p" { GoToPreviousTab; }

          // toggle floating pane（你的 popup 替代品）
          bind "'" { ToggleFloatingPanes; }
        }

        // ── Tmux-like prefix mode（Ctrl-a 進入）────────────────
        tmux {
          bind "Ctrl a" { SwitchToMode "Normal"; } // 再按一次離開
          bind "Esc" { SwitchToMode "Normal"; }

          // pane 操作
          bind "_" { NewPane "Down"; SwitchToMode "Normal"; }           // 水平分割
          bind "-" { NewPane "Right"; SwitchToMode "Normal"; }          // 垂直分割
          bind "x" { CloseFocus; SwitchToMode "Normal"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }

          // floating pane toggle（同 normal mode 的 '）
          bind "'" { ToggleFloatingPanes; SwitchToMode "Normal"; }
          // 開一個新的 floating pane
          bind "f" { NewFloatingPane; SwitchToMode "Normal"; }

          // pane navigation
          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }

          // pane resize
          bind "H" { Resize "Increase Left"; }
          bind "J" { Resize "Increase Down"; }
          bind "K" { Resize "Increase Up"; }
          bind "L" { Resize "Increase Right"; }

          // tab（window）操作
          bind "c" { NewTab; SwitchToMode "Normal"; }
          bind "d" { Detach; }
          bind "Tab" { GoToNextTab; SwitchToMode "Normal"; }
          bind "," { RenameTab; SwitchToMode "RenameTab"; }

          // tab navigation
          bind "Ctrl h" { GoToPreviousTab; SwitchToMode "Normal"; }
          bind "Ctrl l" { GoToNextTab; SwitchToMode "Normal"; }
          bind "Ctrl j" { MoveTab "Left"; SwitchToMode "Normal"; }  // swap tab left
          bind "Ctrl k" { MoveTab "Right"; SwitchToMode "Normal"; } // swap tab right

          // session manager（內建，類似 sesh 的 session list）
          bind "s" { LaunchOrFocusPlugin "session-manager" { floating true; }; SwitchToMode "Normal"; }

          // zoxide fuzzy finder（替代 sesh + zoxide）
          // 開一個 floating pane 執行 zoxide + fzf，選完後在新 tab 開啟
          bind "o" {
            LaunchOrFocusPlugin "terminal" {
              floating true;
              command "bash";
              args "-c" "dir=$(zoxide query -l | fzf --reverse --prompt 'cd> ') && zellij action new-tab --cwd \"$dir\"";
            };
            SwitchToMode "Normal";
          }
        }

        // ── Scroll / copy mode（vi-like）────────────────────────
        scroll {
          bind "Ctrl a" { SwitchToMode "Normal"; }
          bind "Esc" { SwitchToMode "Normal"; }
          bind "e" { EditScrollback; SwitchToMode "Normal"; }

          // vi navigation
          bind "j" { ScrollDown; }
          bind "k" { ScrollUp; }
          bind "d" { HalfPageScrollDown; }
          bind "u" { HalfPageScrollUp; }
          bind "G" { ScrollToBottom; SwitchToMode "Normal"; }

          // 進入 copy mode
          bind "v" { SwitchToMode "EnterSearch"; }
        }

        entersearch {
          bind "Ctrl a" { SwitchToMode "Normal"; }
          bind "Esc" { SwitchToMode "Scroll"; }
          bind "Enter" { SwitchToMode "Search"; }
        }

        search {
          bind "Ctrl a" { SwitchToMode "Normal"; }
          bind "Esc" { SwitchToMode "Scroll"; }
          bind "n" { Search "down"; }
          bind "N" { Search "up"; }
          bind "c" { SearchToggleOption "CaseSensitivity"; }
          bind "w" { SearchToggleOption "WholeWord"; }
        }

        // ── Rename tab mode ──────────────────────────────────────
        renamepane {
          bind "Esc" { UndoRenamePane; SwitchToMode "Normal"; }
        }
      }
    '';

    # Rose Pine theme for zellij
    xdg.configFile."zellij/themes/rose-pine.kdl".text = ''
      themes {
        rose-pine {
          fg "#e0def4"
          bg "#191724"
          black "#26233a"
          red "#eb6f92"
          green "#31748f"
          yellow "#f6c177"
          blue "#9ccfd8"
          magenta "#c4a7e7"
          cyan "#ebbcba"
          white "#e0def4"
          orange "#f6c177"
        }
      }
    '';
  };
}
