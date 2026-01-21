{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.programs.utils.enable = lib.mkEnableOption "Enable utils programs";

  config = lib.mkIf config.myHome.programs.utils.enable {
    home.packages = with pkgs; [
      # utils
      age # A simple, modern and secure encryption tool
      just # A handy way to save and run project-specific commands
      axel # A light download accelerator
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      unzip # A utility for unpacking zip file
      unar # A program to extract, list, test and view the contents of archives
      ripgrep # A line-oriented search tool that recursively searches your current directory for a regex pattern
      yq-go # yaml processer https://github.com/mikefarah/yq
      jq # A lightweight and flexible command-line JSON processor
      inkscape # vector graphics utility
      jless
      btop
      openssl
      mkcert
      termscp
      pwgen
      lsof
      lazygit

      # misc
      onefetch # Git repository summary generator
      tokei # A program that displays statistics about your code
    ];

    programs = {
      # A modern replacement for ‘ls’
      eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableZshIntegration = true;
      };

      # terminal file manager
      yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          manager = {
            show_hidden = true;
            sort_dir_first = true;
          };
        };
      };

      # skim provides a single executable: sk.
      # Basically anywhere you would want to use grep, try sk instead.
      skim = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
