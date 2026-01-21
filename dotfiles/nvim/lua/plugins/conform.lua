--- @type LazySpec
return {
  {
    "stevearc/conform.nvim",
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      local dprint_supported = {
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
        "svelte",
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
