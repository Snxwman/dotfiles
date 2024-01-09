return {
    {
        "zaldih/themery.nvim",
        lazy = false,
        opts = {
            themes = {
                "tokyonight",
                "flexoki-dark",
                "oxocarbon",
                "moonfly"
            },
            themeConfigFile = "~/.config/nvim/lua/plugins/theme.lua",
            livePreview = "true"
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "night" },
    },
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
    },
    { 
        "bluz71/vim-moonfly-colors", 
        name = "moonfly", 
    },
}
