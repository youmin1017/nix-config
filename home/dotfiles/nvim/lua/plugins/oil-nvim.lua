---@type NvPluginSpec
local spec = {
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    cmd = "Oil",
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open oil.nvim",
      },
    },
    opts = {
      delete_to_trash = true,
      keymaps = {
        -- ["I"] = "actions.toggle_hidden",
        -- ["g."] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["S"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["R"] = "actions.refresh",
        ["`"] = "actions.cd",
      },
    },
  },
}
return spec
