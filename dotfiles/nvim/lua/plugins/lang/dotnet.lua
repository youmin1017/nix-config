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
}
