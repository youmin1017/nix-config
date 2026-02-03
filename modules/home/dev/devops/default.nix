{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.devops.enable = lib.mkEnableOption "devops packages";

  config = lib.mkIf config.myHome.dev.devops.enable {
    home.packages = with pkgs; [
      # DevOps
      kubectl
      # kubernetes-helm
      k9s
      # telepresence2
    ];
  };
}
