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
        neovim.enable = true;
      };
    };
  };
}
