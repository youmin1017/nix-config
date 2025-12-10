{ inputs, pkgs, ... }:
{
  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    # lsp
    helm-ls
    lua-language-server
    marksman
    nil
    statix

    # formatter
    kdlfmt
    nixfmt-rfc-style
    stylua
    biome
    ruff
    dprint

    # linter
    hadolint # Dockerfile linter

    # misc
    unzip # for mason.nvim
    tree-sitter
  ];
}
