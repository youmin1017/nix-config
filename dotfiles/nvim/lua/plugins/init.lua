---@type LazySpec
return {
  { import = "plugins.lang.go" },
  { import = "plugins.lang.typescript" },
  { import = "plugins.lang.just" },

  {
    "LazyVim/LazyVim",
    opts = {
      news = {
        lazyvim = false,
        neovim = false,
      },
    },
  },
}
