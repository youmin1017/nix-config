{ pkgs, ... }:
{
  imports = [
    ./postgresql.nix
    ./traefik.nix # Traefik reverse proxy
    ./zitadel.nix # ZITADEL identity and access management
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Networking
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    80 # HTTP
    443 # HTTPS
    # 8080 # Traefik dashboard
  ];

  # Programs
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
