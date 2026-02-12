{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHome.programs.zsh.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf config.myHome.programs.zsh.enable {
    programs.zsh = {
      enable = true;
      initContent = lib.mkMerge [
        (lib.mkOrder 550 ''
          zstyle ':completion:*' matcher-list '''''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
          zstyle ':fzf-tab:*' fzf-pad 4
          function zvm_config() {
            ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
            ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
            ZVM_KEYTIMEOUT=0.03
          }

          function zvm_after_init() {
            eval "$(fzf --zsh)"
          }
        '')
        (lib.mkOrder 1200 ''
          export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"
          export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
        '')
      ];

      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      antidote = {
        enable = true;
        plugins = [
          "Aloxaf/fzf-tab"
          "jeffreytse/zsh-vi-mode"
          "paulirish/git-open"
        ];
      };
    };

    home.shellAliases = lib.mkMerge [
      {
        k = "kubectl";
        cz = "chezmoi";
        lg = "lazygit";
        oc = "opencode";

        urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
        urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      }
      (lib.mkIf pkgs.stdenv.isDarwin {
        rm = "trash";
        ii = "open -a Finder.app";
      })
      (lib.mkIf pkgs.stdenv.isLinux {
        zed = "zeditor";
      })
    ];
  };
}
