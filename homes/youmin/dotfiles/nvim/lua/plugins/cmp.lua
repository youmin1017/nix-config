---@type NvPluginSpec
return {
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    ---@type blink.cmp.Config
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "snippets", "buffer", "path" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      keymap = {
        -- stylua: ignore
        ["<C-s>"] = { function(cmp) cmp.show() end, },
      },
    },
  },
}
