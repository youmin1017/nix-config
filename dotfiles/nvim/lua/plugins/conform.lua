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
      opts.formatters = opts.formatters or {}

      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- local dprint_supported = {
      --   "dockerfile",
      --   "svelte",
      -- }
      --
      -- for _, ft in ipairs(dprint_supported) do
      --   opts.formatters_by_ft[ft] = { "dprint" }
      -- end

      -- local biome_supported = {
      --   "astro",
      --   "css",
      --   "graphql",
      --   -- "html",
      --   "javascript",
      --   "javascriptreact",
      --   "json",
      --   "jsonc",
      --   -- "markdown",
      --   "svelte",
      --   "typescript",
      --   "typescriptreact",
      --   "vue",
      -- }
      --
      -- for _, ft in ipairs(biome_supported) do
      --   opts.formatters_by_ft[ft] = { "biome" }
      -- end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })
    end,
  },
}
