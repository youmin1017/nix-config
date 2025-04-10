{
  impurity,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source = impurity.link ../dotfiles/nvim;
}
