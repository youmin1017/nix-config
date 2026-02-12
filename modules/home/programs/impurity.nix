{
  self,
  config,
  lib,
  ...
}:
{
  options.myHome.programs.impurity.enable =
    lib.mkEnableOption "Enable the impurity program in myHome.";

  imports = [
    self.inputs.impurity.nixosModules.impurity
  ];

  config = lib.mkIf config.myHome.programs.impurity.enable {
    impurity.configRoot = self;
    impurity.enable = true;
  };
}
