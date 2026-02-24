{ self, pkgs, ... }:
{
  home-manager.users.youmin = {
    imports = [
      self.homeModules.youmin
    ];

    myHome = {
      dev = {
        ai.enable = true;
        # devops.enable = true;
        node.enable = true;
        nix.enable = true;
        # latex.enable = true;
        # rust = {
        #   enable = true;
        #   package = pkgs.rust-bin.stable.latest.default.override {
        #     targets = [ "wasm32-unknown-unknown" ];
        #   };
        # };
      };

      profiles = {
        fcitx5.enable = true;
      };

      programs = {
        impurity.enable = true;
        ideavim.enable = true;
        neovim.enable = true;
        noctalia.enable = true;
        utils.enable = true;
        starship.enable = true;
        tmux.enable = true;
        zed.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };

      services = {
        vicinae.enable = true;
        nm-applet.enable = true;
      };
    };
  };
}
