return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "nix",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "nil_ls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                nil_ls = {},
            }
        }
    }
}


