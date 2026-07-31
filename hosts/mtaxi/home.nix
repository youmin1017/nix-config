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
        dotnet = {
          enable = true;
          sdk =
            with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_10_0
              sdk_6_0
            ];
        };
      };

      profiles = {
        fcitx5.enable = true;
      };

      programs = {
        git = {
          user.name = "youmin1017";
          user.email = "youmin.wu@mobile.com.tw";
        };
        impurity.enable = true;
        jujutsu.enable = true;
        neovim.enable = true;
        utils.enable = true;
        starship.enable = true;
        tmux = {
          enable = true;
          terminal = "xterm-256color";
        };
        zoxide.enable = true;
        zsh.enable = true;
      };
    };
  };
}
