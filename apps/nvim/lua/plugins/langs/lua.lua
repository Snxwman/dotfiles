return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "fennel",
                "lua",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "fennel_language_server",
                "lua_ls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                fennel_language_server = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                                disable = { "missing-fields" },
                            },
                            workspace = {
                                library = { vim.env.VIMRUNTIME },
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        }
                    }
                },
            }
        },
    },
    {
        "folke/lazydev.nvim",
        ft = { "lua" },
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {  -- optional cmp completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
