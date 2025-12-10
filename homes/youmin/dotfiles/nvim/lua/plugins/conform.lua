--- @type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        dprint = {
          condition = function(ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      local supported = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "html",
        "yaml",
        "toml",
        "scss",
        "less",
        "vue",
        "dockerfile",
        "python",
      }

      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = { "dprint" }
      end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
