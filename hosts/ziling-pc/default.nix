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

  networking.hostName = "ziling-pc";
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
    proton-pass-cli

    # Gnome apps
    baobab
    nautilus
    gnome-disk-utility

    # dev
    sqlite
    act
  ];

  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  };

  myHardware = {
    amd.cpu.enable = true;
    nvidia.gpu.enable = true;
  };

  myNixOS = {
    base.enable = true;
    desktop.hyprland.enable = true;

    programs = {
      nix.enable = true;
      # systemd-boot.enable = true;
      lanzaboote.enable = true;

      # browsers
      chromium.enable = true;
      firefox.enable = true;
      zen-browser.enable = true;
    };

    services = {
      # greetd.enable = true;
      ly.enable = true;
      kanata.enable = true;
      tailscale.enable = true;
      udisks2.enable = true;
    };
  };

  myUsers.youmin = {
    enable = true;
    hashedPasswordFile = config.age.secrets."youmin-password".path;
  };

  age.secrets = {
    "youmin-password".file = "${self}/secrets/youmin-password.age";
  };
}
