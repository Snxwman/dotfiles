local filetypes = { "gitcommit", "gitconfig", "gitrebase", "gitignore", "gitattributes" }
return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
            }
        }
    },
}
