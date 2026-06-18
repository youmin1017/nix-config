---@diagnostic disable: missing-fields
---@type LazySpec
return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    ---@type easy-dotnet.Options
    opts = {
      picker = "snacks",
      lsp = {
        enabled = true,
        auto_refresh_codelens = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local dotnet = require("easy-dotnet")
      table.insert(opts.sections.lualine_x, 1, {
        dotnet.lualine.run_status,
        color = dotnet.lualine.run_status_color,
        on_click = dotnet.lualine.run_status_click,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "razor" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
      },
    },
  },
}
