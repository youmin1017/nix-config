{ impurity, ... }:
{
  xdg.configFile =
    let
      link = impurity.link;
    in
    {
      "ideavim".source = link ../dotfiles/ideavim;
      "nvim".source = link ../dotfiles/nvim;
      "nvim-vscode".source = link ../dotfiles/nvim-vscode;
      "ghostty".source = link ../dotfiles/ghostty;
      "zed/keymap.json".source = link ../dotfiles/zed/keymap.json;
      "zed/settings.json".source = link ../dotfiles/zed/settings.json;
      "zellij".source = link ../dotfiles/zellij;
    };
}
