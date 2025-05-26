---@type NvPluginSpec
return {
  { import = "plugins.lsp.lua" },
  { import = "plugins.lsp.svelte" },
  { import = "plugins.lsp.vtsls" },
  { import = "plugins.lsp.nix" },
  { import = "plugins.lsp.rust" },
  { import = "plugins.lsp.docker" },
  { import = "plugins.lsp.sql" },
  { import = "plugins.lsp.go" },
  { import = "plugins.lsp.json" },
  { import = "plugins.lsp.yaml" },
  { import = "plugins.lsp.clangd" },
  { import = "plugins.lsp.tex" },
  { import = "plugins.lsp.tailwindcss" },
  { import = "plugins.lsp.eslint" },

  { import = "configs.format.deno" },
  -- { import = "configs.format.prettier" },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig",
    },
    config = require("configs.lspconfig").defaults,
  },
}
