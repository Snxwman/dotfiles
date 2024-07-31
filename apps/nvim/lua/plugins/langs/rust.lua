return {
    {
        'mrcjkb/rustaceanvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            "adaszko/tree_climber_rust.nvim",
        },
        version = '^5', -- Recommended
        enabled = true,
        lazy = false,
        ft = { 'rust' },
        keys = {
            {"K", "<cmd>RustLsp hover actions<cr>", desc = "Hover actions (rust)"},
            {"<leader>bk", "<cmd>RustLsp moveItem up<cr>", desc = "Move block up (rust)"},
            {"<leader>bj", "<cmd>RustLsp moveItem down<cr>", desc = "Move block down (rust)"},
            {"<leader>J", "<cmd>RustLsp joinLines<cr>", desc = "Join selected lines (rust)"},
            {"<leader>ca", "<cmd>RustLsp codeAction<cr>", desc = "Code actions (rust)"},
            {"<leader>dr", "<cmd>RustLsp debuggables<cr>", desc = "Debuggables (rust)"},
            {"<leader>Oc", "<cmd>RustLsp openCargo<cr>", desc = "Open Cargo.toml (rust)"},
            {"<leader>Od", "<cmd>RustLsp openDocs<cr>", desc = "Open web doc for current symbol (rust)"},
        },
        opts = {
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            buildScripts = {
                                enable = true,
                            },
                        },
                        checkOnSave = true,
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    },
                },
            },
        },
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, bufnr)
                        local opts = { noremap=true, silent=true }
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 's', '<cmd>lua require("tree_climber_rust").init_selection()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'x', 's', '<cmd>lua require("tree_climber_rust").select_incremental()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'x', 'S', '<cmd>lua require("tree_climber_rust").select_previous()<CR>', opts)
                    end,
                },
            }
        end
    },
}
