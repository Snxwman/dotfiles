return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "css",
                "scss",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "cssls",
                "tailwindcss",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                cssls = {},
                tailwindcss = {},
            }
        }
    }
}
