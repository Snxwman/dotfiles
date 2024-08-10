return {
    {
        "zaldih/themery.nvim",
        lazy = false,
        opts = {
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
        lazy = true,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        name = "oxocarbon",
        lazy = true,
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = true,
    },
    {
        "NLKNguyen/papercolor-theme",
        name = "papercolor",
        lazy = true,
    },
    {
        "ayu-theme/ayu-vim",
        name = "ayu",
        lazy = true,
    },
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        lazy = true,
    },
    {
        "zootedb0t/citruszest.nvim",
        name = "citruszest",
        lazy = true,
    },
    {
        "jaredgorski/SpaceCamp",
        name = "spacecamp",
        lazy = true,
    },
    {
        "safv12/andromeda.vim",
        name = "andromeda",
        lazy = true,
    },
    {
        "bratpeki/truedark-vim",
        name = "truedark",
        lazy = true,
    },
    {
        "justb3a/vim-smarties",
        name = "smarties",
        lazy = true,
    },
    {
        "daltonmenezes/aura-theme",
        name = "aura-dark",
        lazy = true,
    },
}
