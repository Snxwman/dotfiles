return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "dockerfile",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "dockerls",
                "docker_compose_language_service",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                dockerls = {},
                docker_compose_language_service = {},
            }
        }
    }
}
