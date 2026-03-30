--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- "biome",
        -- "dprint",
        "oxfmt",
        -- "oxlint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- local dprint_supported = {
      --   "javascript",
      --   "typescript",
      --   "javascriptreact",
      --   "typescriptreact",
      --   "json",
      --   "jsonc",
      --   "css",
      --   "html",
      --   "yaml",
      --   "toml",
      --   "scss",
      --   "less",
      --   "vue",
      --   "dockerfile",
      --   "python",
      --   "svelte",
      -- }
      --
      -- for _, ft in ipairs(dprint_supported) do
      --   opts.formatters_by_ft[ft] = { "dprint" }
      -- end

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

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
