---@type LazySpec
local spec = {
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    lazy = false,
    cmd = "Oil",
    keys = {
      {
        "-",
        function()
          require("oil").open(nil, { preview = {} })
        end,
        desc = "File Open oil.nvim",
      },
    },
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      keymaps = {
        -- ["g."] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-p>"] = false,
        ["-"] = "actions.close",
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["s"] = { "<cmd>write<cr>", mode = "n", desc = "Sync/apply changes" },
        ["R"] = "actions.refresh",
        ["H"] = "actions.toggle_hidden",
        ["."] = "actions.cd",
        ["<BS>"] = "actions.parent",
        [";"] = { ":", mode = "n", desc = "Command mode" },
      },
      float = {
        max_width = 0.9,
        max_height = 0.9,
        border = "rounded",
        preview_split = "right",
      },
    },
  },
}
return spec
