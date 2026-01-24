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
      axel # A light download accelerator
      btop # A customizable resource monitor (CPU, memory, disks, network)
      hey # A tiny program for HTTP benchmarking and load testing
      inkscape # A professional vector graphics editor and utility
      jless # A command-line JSON viewer and pager for interactive exploration
      jq # A lightweight and flexible command-line JSON processor
      just # A handy way to save and run project-specific commands
      lazygit # A simple terminal UI for git commands
      lsof # A utility that lists information about files opened by processes
      mkcert # A simple tool for making locally-trusted development certificates
      nmap # A utility for network discovery and security auditing
      openssl # A robust toolkit for TLS and general-purpose cryptography
      pwgen # A password generator that creates easy-to-memorize, secure passwords
      ripgrep # A fast, line-oriented search tool (recursive regex search)
      socat # A multipurpose relay (bidirectional data transfer) and netcat replacement
      termscp # A terminal file explorer with support for SCP, SFTP, FTP, and S3
      unar # A program to extract, list, and view contents of various archive formats
      unzip # A utility for unpacking .zip archives
      yq-go # A portable command-line YAML processor

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

      bat = {
        enable = true;
      };
      fd = {
        enable = true;
        ignores = [
          ".git/"
          "*.bak"
          "node_modules/"
          "build/"
        ];
      };
      fzf = {
        enable = true;
        defaultCommand = "fd --hiden --strip-cwd-prefix";
        defaultOptions = [
          "--color=dark"
          "--height 100%"
          "--layout=default"
          "--border"
        ];

        fileWidgetCommand = "fd --type f --hidden --strip-cwd-prefix";
        fileWidgetOptions = [
          "--preview"
          "'bat --color=always -n --line-range :500 {}'"
        ];

        # dracula
        colors = {
          "fg" = "-1";
          "bg" = "-1";
          "hl" = "#5fff87";
          "fg+" = "-1";
          "bg+" = "-1";
          "hl+" = "#ffaf5f";
          "info" = "#af87ff";
          "prompt" = "#5fff87";
          "pointer" = "#ff87d7";
          "marker" = "#ff87d7";
          "spinner" = "#ff87d7";
        };
      };
    };
  };
}
