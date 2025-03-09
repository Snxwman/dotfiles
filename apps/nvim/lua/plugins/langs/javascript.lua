return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "javascript",
                "svelte",
                "typescript",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "htmx",
                "svelte",
                "ts_ls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                htmx = {},
                svelte = {},
                ts_ls = {}
            }
        }
    }
}


