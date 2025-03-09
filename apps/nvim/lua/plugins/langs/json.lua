return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "Myzel394/jsonfly.nvim",
        },
        keys = {
            {
                "<leader>j",
                "<cmd>Telescope jsonfly<cr>",
                desc = "Open json(fly)",
                ft = { "json", "xml", "yaml" },
                mode = "n"
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "jq",
                "json",
                "json5",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "jsonls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {},
            }
        }
    }
}
