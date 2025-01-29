{ pkgs, ... }:
{
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
    bruno # A Opensource IDE For Exploring and Testing Api's
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      LINE = 539883307;
      Messenger = 1480068668;
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "bitwarden-cli"
      "deno"
      "ko"
      "podman"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "arc"
      "appcleaner"
      "chatgpt"
      "datagrip"
      "discord"
      "ghostty"
      "jordanbaird-ice"
      "karabiner-elements"
      "microsoft-teams"
      "notion"
      "orbstack"
      "obsidian"
      "podman-desktop"
      "raycast"
      "rider"
      "spotify"
      "zed"
    ];
  };

  system.defaults.dock.persistent-apps = [
    "/System/Applications/Launchpad.app"
    "/Applications/Arc.app"
    "/Applications/Zed.app"
    "/Applications/Ghostty.app"
    "/Applications/Obsidian.app"
    "/Applications/Notion.app"
    "/Applications/Notion Calendar.app"
    "/System/Applications/Mail.app"
    "/Applications/LINE.app"
    "/Applications/Discord.app"
    "/Applications/Messenger.app"
    # "${pkgs.jetbrains.datagrip}/Applications/DataGrip.app"
    "/Applications/DataGrip.app"
    "/Applications/Podman Desktop.app"
    "/Users/youmin/Applications/iCloud.app"
    "/Applications/Spotify.app"
    "/System/Applications/Notes.app"
  ];
}
