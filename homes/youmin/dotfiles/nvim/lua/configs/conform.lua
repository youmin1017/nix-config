local options = {
  formatters_by_ft = {
    lua = { "stylua" },
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf, timeout_ms = 500 }
  end,
})

return options
