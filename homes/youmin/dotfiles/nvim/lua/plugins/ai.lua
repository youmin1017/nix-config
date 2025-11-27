---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    keys = {
      { "<M-l>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
      {
        "<M-u>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {
          keys = {
            {
              "<M-]>",
              function()
                vim.lsp.inline_completion.select({ count = 1 })
              end,
              desc = "Next Copilot Suggestion",
              mode = { "i", "n" },
            },
            {
              "<M-[>",
              function()
                vim.lsp.inline_completion.select({ count = -1 })
              end,
              desc = "Prev Copilot Suggestion",
              mode = { "i", "n" },
            },
            {
              "<M-l>",
              function()
                LazyVim.cmp.actions.ai_accept()
              end,
              mode = { "i" },
            },
          },
        },
      },
    },
  },
}
