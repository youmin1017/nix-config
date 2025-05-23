-- vim.lsp.config("eslint", {
--   on_attach = function(client, bufnr)
--     require("configs.lspconfig").on_attach(client, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "LspEslintFixAll",
--     })
--   end,
-- })
vim.lsp.enable "eslint"

---@type NvPluginSpec
return {
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "eslint" })
    end,
  },
}
