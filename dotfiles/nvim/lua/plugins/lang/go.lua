---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          ---@type lspconfig.settings.gopls
          settings = {
            gopls = {
              staticcheck = false,
            },
          },
        },
      },
    },
  },
}
