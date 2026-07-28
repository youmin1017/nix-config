{
  self,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    self.nixosModules.locale-zh-tw
  ];

  networking = {
    hostName = "mtaxi";
    # nameservers = [
    #   "1.1.1.1"
    #   "8.8.8.8"
    # ];
  };

  system.stateVersion = "25.11";
  time.timeZone = "Asia/Taipei";
  time.hardwareClockInLocalTime = true;

  environment.systemPackages = with pkgs; [
  ];

  wsl = {
    defaultUser = "youmin";
  };

  myNixOS = {
    wsl.enable = true;
    programs = {
      nix.enable = true;
    };
  };

  myUsers.youmin = {
    enable = true;
    hashedPasswordFile = config.age.secrets."mtaxi-youmin-password".path;
  };

  age.secrets = {
    "mtaxi-youmin-password".file = "${self}/secrets/mtaxi-youmin-password.age";
  };
}
