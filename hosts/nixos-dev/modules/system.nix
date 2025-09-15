{ pkgs, ... }:
{
  imports = [
    ./postgresql.nix
    ./caddy.nix
    ./keycloak.nix
    ./headscale.nix
    ./s3.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Virtualization
  virtualisation.docker.enable = true;

  # Networking
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    80 # HTTP
    443 # HTTPS
  ];
  networking.nat = {
    enable = true;
    externalInterface = "eth0";
    internalInterfaces = [ "tailscale0" ];
    # Allow forwarding for Tailscale subnet (100.64.0.0/10)
    internalIPs = [ "100.64.0.0/10" ];
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # Programs
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
