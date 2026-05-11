-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""
vim.opt.relativenumber = false

vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".env.*"] = "sh",
  },
})

-- LazyVim  Options

---@type "vtsls" | "tsgo"
vim.g.lazyvim_ts_lsp = "tsgo"

---@type "rust-analyzer" | "bacon-ls"
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
