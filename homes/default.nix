{
  outputs,
  inputs,
  impurity,
  isDarwin,
  minimal,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit
        outputs
        inputs
        impurity
        isDarwin
        minimal
        ;
    };
    users = {
      youmin = ./youmin;
    };
    # useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
