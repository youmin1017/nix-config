{
  outputs,
  inputs,
  impurity,
  isDarwin,
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
