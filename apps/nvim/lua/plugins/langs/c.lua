return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c",
                "cmake",
                "cpp",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {}
            }
        }
    }
}
