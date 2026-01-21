---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            tsserver = {
              experimental = {
                enableProjectDiagnostics = true,
              },
            },
          },
        },
      },
    },
  },
}
