-- better vim.ui with telescope
--- @type NvPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
    -- stylua: ignore end
  },
}
