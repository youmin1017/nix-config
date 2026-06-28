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
        rust = {
          enable = true;
          # using nightly to support -Z flag
          package = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default);
        };
      };

      profiles = {
        fcitx5.enable = true;
      };

      programs = {
        herdr.enable = true;
        impurity.enable = true;
        ideavim.enable = true;
        neovim.enable = true;
        noctalia.enable = true;
        utils.enable = true;
        starship.enable = true;
        tmux.enable = true;
        vicinae.enable = true;
        zed.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };

      services = {
        nm-applet.enable = true;
      };
    };
  };
}
