{
  self,
  impurity,
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.programs.neovim =
    let
      inherit (lib.types)
        bool
        str
        int
        nullOr
        attrsOf
        oneOf
        path
        listOf
        ;
    in
    {
      enable = lib.mkEnableOption "neovim screenshot tool";

      lazyvim = lib.mkOption {
        type = lib.types.submodule {
          freeformType = attrsOf (
            nullOr (oneOf [
              str
              int
              bool
              (attrsOf path)
            ])
          );
          options = {
            extras = lib.mkOption {
              type = listOf str;
              default = [ ];
              example = [
                "lazyvim.plugins.extras.lang.nix"
              ];
              description = "A list of extra LazyVim plugins to include in your Neovim configuration.";
            };
          };
        };
      };
    };

  config = lib.mkIf config.myHome.programs.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    home.packages = with pkgs; [
      tree-sitter
    ];

    # default extras
    myHome.programs.neovim.lazyvim = {
      extras = [
        "lazyvim.plugins.extras.editor.mini-files"
      ];
      install_version = 8;
      version = 8;
    };

    xdg.configFile =
      lib.genAttrs
        [
          "nvim/lua"
          "nvim/init.lua"
          "nvim/.neoconf.json"
          "nvim/lazy-lock.json"
          "nvim/stylua.toml"
        ]
        (name: {
          source = impurity.link "${self}/dotfiles/${name}";
        })
      // {
        "nvim/lazyvim.json".source = pkgs.writeText "lazyvim.json" (
          builtins.toJSON config.myHome.programs.neovim.lazyvim
        );
      };
  };
}
