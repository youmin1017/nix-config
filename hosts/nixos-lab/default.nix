{ self, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./file-system.nix
    self.nixosModules.locale-zh-tw
  ];

  networking.hostName = "nixos-lab";
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
    antigravity
    brave
    onlyoffice-desktopeditors
    quickemu
    remmina
    spotify
    telegram-desktop
    teams-for-linux
    vesktop # Alternative Discord Client
    wl-clipboard

    jetbrains.datagrip

    proton-vpn
    proton-pass
    proton-pass-cli

    # Gnome apps
    baobab
    nautilus
    gnome-disk-utility

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
    # amd.cpu.enable = true;
    # nvidia.gpu.enable = true;
    intel = {
      cpu.enable = true;
      gpu.enable = true;
    };
  };

  myNixOS = {
    base.enable = true;
    desktop.hyprland = {
      enable = true;
      monitors = [
        "DP-6,1920x1080@143.85,-1920x0,1"
        "DP-4,1920x1080@100.00,0x0,1"
        "DP-5,1920x1080@100.00,1920x-420,1,transform,3"
      ];
    };

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
      greetd.enable = true;
      kanata.enable = true;
      tailscale.enable = true;
      udisks2.enable = true;
    };
  };

  myUsers.youmin = {
    enable = true;
    password = "$y$j9T$y/RoOCq.7l3Z9FVgcYH9b1$qU9U9Nzs8y4o1VRnYA2.SHBCSeW71RSCzJSXc96rz.4";
  };
}
