--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- "biome",
        "dprint",
        "oxfmt",
        "oxlint",
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

      local oxfmt_supported = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",

        "json",
        "jsonc",
        "yaml",
        "toml",

        "html",
        "css",

        "dockerfile",
        "graphql",
      }

      for _, ft in ipairs(oxfmt_supported) do
        opts.formatters_by_ft[ft] = { "oxfmt" }
      end

      -- "svelte",

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "oxfmt", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "oxfmt", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
