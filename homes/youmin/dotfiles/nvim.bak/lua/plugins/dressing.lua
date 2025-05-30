-- better vim.ui with telescope
--- @type NvPluginSpec
return {
  "stevearc/dressing.nvim",
  enabled = false,
  lazy = true,
  -- enabled = function()
  --   return LazyVim.pick.want() == "telescope"
  -- end,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load { plugins = { "dressing.nvim" } }
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load { plugins = { "dressing.nvim" } }
      return vim.ui.input(...)
    end
  end,
}
