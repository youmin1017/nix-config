{ pkgs, ... }:
{
  services.minecraft-server = {
    package = pkgs.papermcServers.papermc-1_21_5;
    enable = true;
    eula = true;
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
