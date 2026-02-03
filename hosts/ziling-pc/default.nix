{ self, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./file-system.nix
    self.nixosModules.locale-zh-tw
  ];

  networking.hostName = "ziling-pc";
  system.stateVersion = "25.11";
  time.timeZone = "Asia/Taipei";

  environment.systemPackages = with pkgs; [
    antigravity
    brave
    onlyoffice-desktopeditors
    k6
    nautilus
    pandoc
    remmina
    spotify
    telegram-desktop

    jetbrains.datagrip
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
    desktop.hyprland = {
      enable = true;
      monitors = [
        "desc:ASUSTek COMPUTER INC XG27ACS TALMTF024962,2560x1440@180,0x0,1"
        "desc:Microstep MSI MPG341CQR 0x00000098,3440x1440@144,-3440x-360,1"
      ];
    };

    programs = {
      nix.enable = true;
      systemd-boot.enable = true;

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
