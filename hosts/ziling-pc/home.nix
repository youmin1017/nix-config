{ self, ... }:
{
  home-manager.users.youmin = {
    imports = [
      self.homeModules.youmin
    ];

    myHome = {
      dev = {
        nix.enable = true;
      };
      programs = {
        impurity.enable = true;
        neovim.enable = true;
      };
    };
  };
}
