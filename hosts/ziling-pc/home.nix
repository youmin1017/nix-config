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
      };
    };
  };
}
