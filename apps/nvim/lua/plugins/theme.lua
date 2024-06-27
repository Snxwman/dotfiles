return {
    {
        "zaldih/themery.nvim",
        lazy = false,
        opts = {
            themeConfigFile = "~/.config/nvim/lua/theme.lua",
            livePreview = "true",
            themes = {
                {
                    name = "tokyonight moon",
                    colorscheme = "tokyonight-moon",
                },
                {
                    name = "tokyonight night",
                    colorscheme = "tokyonight-night",
                },
                {
                    name = "tokyonight storm",
                    colorscheme = "tokyonight-storm",
                },
                "flexoki-dark",
                "oxocarbon",
                "moonfly",
                "kanagawa",
                -- "papercolor",
                "ayu",
                "dracula",
                "citruszest",
                "spacecamp",
                "andromeda",
                "truedark",
                "smarties",
                {
                    name = "aura dark",
                    colorscheme = "aura-dark",
                    before = [[ vim.opt.rtp:append("~/.local/share/nvim/lazy/aura-dark/packages/neovim/") ]],
                },
                {
                    name = "aura dark (soft text)",
                    colorscheme = "aura-dark-soft-text",
                    before = [[ vim.opt.rtp:append("~/.local/share/nvim/lazy/aura-dark/packages/neovim/") ]],
                },
                {
                    name = "aura soft",
                    colorscheme = "aura-soft-dark",
                    before = [[ vim.opt.rtp:append("~/.local/share/nvim/lazy/aura-dark/packages/neovim/") ]],
                },
                {
                    name = "aura soft (soft text)",
                    colorscheme = "aura-soft-dark-soft-text",
                    before = [[ vim.opt.rtp:append("~/.local/share/nvim/lazy/aura-dark/packages/neovim/") ]],
                },

            },
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        name = "oxocarbon",
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
    },
    {
        "NLKNguyen/papercolor-theme",
        name = "papercolor",
    },
    {
        "ayu-theme/ayu-vim",
        name = "ayu",
    },
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
    },
    {
        "zootedb0t/citruszest.nvim",
        name = "citruszest",
    },
    {
        "jaredgorski/SpaceCamp",
        name = "spacecamp",
    },
    {
        "safv12/andromeda.vim",
        name = "andromeda",
    },
    {
        "bratpeki/truedark-vim",
        name = "truedark",
    },
    {
        "justb3a/vim-smarties",
        name = "smarties",
    },
    {
        "daltonmenezes/aura-theme",
        name = "aura-dark",
    },
}
