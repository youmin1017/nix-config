{ self, ... }:
{
  home-manager.users.youmin = {
    imports = [
      self.homeModules.youmin
    ];

    myHome = {
      dev = {
        ai.enable = true;
        node.enable = true;
        nix.enable = true;
        latex.enable = true;
      };
      programs = {
        impurity.enable = true;
        neovim.enable = true;
        starship.enable = true;
        tmux.enable = true;
        zed.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
    };
  };
}
