{ pkgs, username, ... }:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults
#
###################################################################################
{
  system = {
    primaryUser = username;
    stateVersion = 6;

    defaults = {
      # Customize dock
      dock = {
        autohide = true;
        show-recents = false;
        tilesize = 64;
      };

      # Customize finder
      finder = {
        QuitMenuItem = true; # show quit finder in menu
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # Customize trackpad
      trackpad = {
        Clicking = true; # enable tap to click
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = true; # enable three finger drag
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
  ];

  fonts.packages = with pkgs; [
    material-design-icons
    noto-fonts-cjk-sans
    font-awesome
    nerd-fonts.dejavu-sans-mono
  ];
}
