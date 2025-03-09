return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "elixir",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "elixirls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                elixirls = {
                    cmd = { "/home/sam/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" };
                },
            }
        }
    }
}

