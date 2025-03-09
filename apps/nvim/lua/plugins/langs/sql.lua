return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "sql",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "html",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                html = {},
            }
        }
    }
}

