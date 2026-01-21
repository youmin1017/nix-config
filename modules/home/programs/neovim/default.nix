{
  self,
  impurity,
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.programs.neovim.enable = lib.mkEnableOption "neovim screenshot tool";

  config = lib.mkIf config.myHome.programs.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    home.packages = with pkgs; [
      tree-sitter
    ];

    home.file.".config/nvim".source = impurity.link "${self}/dotfiles/nvim";
  };
}
