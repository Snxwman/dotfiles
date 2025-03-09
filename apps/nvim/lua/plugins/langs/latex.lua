return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "latex",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "ltex",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ltex = {
                    filetypes = { "tex" },
                },
            }
        }
    }
}

