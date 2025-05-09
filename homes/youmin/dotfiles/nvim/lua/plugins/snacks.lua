-- better vim.ui with telescope
--- @type NvPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    bufdelete = { enabled = true },
    lazygit = { enabled = true },
  },
}
