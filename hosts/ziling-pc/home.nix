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
      };
      programs = {
        impurity.enable = true;
        neovim.enable = true;
        starship.enable = true;
        tmux.enable = true;
        zed.enable = true;
        zsh.enable = true;
      };
    };
  };
}
