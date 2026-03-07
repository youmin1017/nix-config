--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- "biome",
        "dprint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- @param opts conform.setupOpts
    opts = function(_, opts)
      local util = require("conform.util")
      opts.formatters = opts.formatters or {}

      ---@type conform.FileFormatterConfig
      opts.formatters.dprint = {
        require_cwd = true,
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      local dprint_supported = {
        -- "javascript",
        -- "javascriptreact",
        -- "typescript",
        -- "typescriptreact",
        "json",
        "jsonc",

        "html",
        "css",
        "svelte",

        "dockerfile",
      }

      for _, ft in ipairs(dprint_supported) do
        opts.formatters_by_ft[ft] = { "dprint" }
      end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
