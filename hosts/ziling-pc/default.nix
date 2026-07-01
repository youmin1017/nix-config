{
  self,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    ./file-system.nix
    self.nixosModules.locale-zh-tw
  ];

  networking = {
    hostName = "ziling-pc";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    # firewall =  {
    #   allowedTCPPorts = [ 22022 ];
    # };
  };

  system.stateVersion = "25.11";
  time.timeZone = "Asia/Taipei";
  time.hardwareClockInLocalTime = true;

  hardware = {
    # enable the firmware for redistributable devices, such as Wi-Fi and Bluetooth adapters
    enableRedistributableFirmware = true;
  };

  virtualisation = {
    docker.enable = true;
    vmware.host.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brave
    onlyoffice-desktopeditors
    gitbutler
    quickemu
    remmina
    spotify
    telegram-desktop
    teams-for-linux
    vesktop # Alternative Discord Client
    nwg-displays

    jetbrains.datagrip
    jetbrains.rider

    proton-vpn
    proton-pass

    # Gnome apps
    baobab
    nautilus
    gnome-disk-utility

    # dev
    sqlite
    act
  ];

  myHardware = {
    amd.cpu.enable = true;
    nvidia.gpu.enable = true;
  };

  myNixOS = {
    base.enable = true;
    desktop.hyprland.enable = true;

    programs = {
      nix.enable = true;
      lanzaboote.enable = true;

      # browsers
      chromium.enable = true;
      firefox.enable = true;
      zen-browser.enable = true;
    };

    services = {
      ly.enable = true;
      kanata.enable = true;
      tailscale.enable = true;
      udisks2.enable = true;
    };
  };

  services.resolved.enable = true;
  services.netbird = {
    # useRoutingFeatures = "both";
    clients.default = {
      name = "netbird";
      port = 51820;
      interface = "wt0";
      hardened = false;
      openFirewall = true;
      openInternalFirewall = true;
    };
  };

  # clients.default = {
  #   name = "netbird";
  #   port = 51820;
  #   interface = "wt0";
  #   hardened = false;
  #   openFirewall = true;
  #   openInternalFirewall = true;
  #   login = {
  #     enable = true;
  #     setupKeyFile = config.age.secrets."netbird-wt0-setup-key".path;
  #   };
  # };

  myUsers.youmin = {
    enable = true;
    hashedPasswordFile = config.age.secrets."youmin-password".path;
  };

  age.secrets = {
    "youmin-password".file = "${self}/secrets/youmin-password.age";
  };
}
