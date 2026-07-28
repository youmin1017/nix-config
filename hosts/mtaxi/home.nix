{ self, pkgs, ... }:
{
  home-manager.users.youmin = {
    imports = [
      self.homeModules.youmin
    ];

    myHome = {
      dev = {
        ai.enable = true;
        node.enable = true;
        python.enable = true;
        nix.enable = true;
        go.enable = true;
        docker.enable = true;
        dotnet.enable = true;
      };

      profiles = {
        fcitx5.enable = true;
      };

      programs = {
        impurity.enable = true;
        jujutsu.enable = true;
        neovim.enable = true;
        utils.enable = true;
        starship.enable = true;
        tmux.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
    };
  };
}
