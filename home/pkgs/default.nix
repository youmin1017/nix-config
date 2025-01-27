{ pkgs, ... }:
{
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    just # A handy way to save and run project-specific commands
    bat # A cat(1) clone with wings
    direnv # Unclutter your .profile
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    unar # A program to extract, list, test and view the contents of archives

    # misc
    # husky # Git hooks made easy
    onefetch # Git repository summary generator
    tokei # A program that displays statistics about your code

    # productivity
    lazygit

    # lsp related
    nixfmt-rfc-style # Nix formatter
    nil
    helm-ls
    hadolint # Dockerfile linter

    # languages
    go
    goose
    rustup
    nodejs_22
    pnpm

    # devops
    # docker-client
    kubernetes-helm
    kubectl
    werf
    buildah
    k9s
  ];

  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
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
      enableBashIntegration = true;
    };
  };
}
