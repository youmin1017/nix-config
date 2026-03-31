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

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- dprint
      opts.formatters.dprint = {
        require_cwd = true,
      }
      local dprint_languages = {
        "dockerfile",
        -- "go",
      }
      for _, ft in ipairs(dprint_languages) do
        opts.formatters_by_ft[ft] = { "dprint" }
      end

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

        "graphql",
      }

      for _, ft in ipairs(oxfmt_supported) do
        opts.formatters_by_ft[ft] = { "oxfmt" }
      end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "oxfmt", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "oxfmt", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
