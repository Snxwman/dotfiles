return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "gowork",
                "templ",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "templ",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    cmd = { "gopls" },
                    filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
                    settings = {
                        gopls = {
                            completeUnimported = true,
                            usePlaceholders = true,
                            analyses = {
                                shadow = true,
                                unusedvariable = true,
                                useany = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        }
                    }
                },
                templ = {
                    filetypes = { "templ" },
                }
            }
        }
    }
}
