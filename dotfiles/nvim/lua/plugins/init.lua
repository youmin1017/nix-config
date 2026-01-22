---@type LazySpec
return {
    { import = "plugins.lang.typescript" },
    { import = "plugins.lang.just" },

    {
        "LazyVim/LazyVim",
        opts = {
            news = {
                lazyvim = false,
                neovim = false,
            },
        }
    }
}
