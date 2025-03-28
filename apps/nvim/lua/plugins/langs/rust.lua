local setup_plugin_keybinds = function(args)
    require("which-key").add({
        -- Custom icon and color for rustaceanvim specific keybinds (will still be in whichkey's LSP group)
        icon = { icon = " ", color = "orange" },
        {
            { "<leader>ld", "<cmd>RustLsp renderDiagnostic<cr>", desc = "[LSP] Show cargo diagnostics"},
            {
                { "<leader>lb", group = "Move block" },
                { "<leader>lbk", "<cmd>RustLsp moveItem up<cr>", desc = "[LSP] Move block up"},
                { "<leader>lbj", "<cmd>RustLsp moveItem down<cr>", desc = "[LSP] Move block down"},
            },
            -- Upper case keys for any command that will change something in the buffer
            { "<leader>lJ", "<cmd>RustLsp joinLines<cr>", desc = "Join selected lines"},
            {
                { "<leader>lg", group = "Go to..." },
                { "<leader>lgd", "<cmd>RustLsp relatedDiagnostics<cr>", desc = "[LSP] Go to related diagnostics" },
            },
        },
        {
            { "<leader>lO", group = "Open..." },
            { "<leader>lOc", "<cmd>RustLsp openCargo<cr>", desc = "[LSP] Open Cargo.toml"},
            { "<leader>lOd", "<cmd>RustLsp openDocs<cr>", desc = "[LSP] Open web doc for current symbol"}
        },
        {
            -- TODO: Can require be removed from these keybinds, or moved to its own plugin config?
            group = "Tree climber",
            {"s", "<cmd>lua require('tree_climber_rust').init_selection()<CR>", desc = "[Tree climber] start selection"},
            {
                mode = "x",
                {"s", "<cmd>lua require('tree_climber_rust').select_incremental()<CR>", desc = "[Tree climber] increment selection" },
                {"S", "<cmd>lua require('tree_climber_rust').select_previous()<CR>", desc = "[Tree climber] decrement selection" }
            }
        },
    });
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "rust",
                "ron",
            }
        }
    },
    {
        "mrcjkb/rustaceanvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "mfussenegger/nvim-dap",
            "adaszko/tree_climber_rust.nvim",
        },
        version = "^5",
        config = function()
            -- Dont clear the group here, we are adding to it.
            -- Clearing is handled in lspconfig's init function.
            local lsp_attach_augroup = vim.api.nvim_create_augroup("user_lsp_config", { clear = false })

            -- This autocmd is created in the config function, so that it is defined after the autocmds defined 
            -- in lspconfig's init function, which allows these keybinds to override any previously defined.
            -- Lazy.nvim executes all init functions prior to config functions.
            --
            -- Defining ft for lazy.nvim ensures that the autocommand is not added when not in a rust file.
            --
            -- Keybinds are in addition to, or overrides of, any lsp keybinds already defined.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_attach_augroup,
                desc = "[Rustaceanvim] Setup LSP keybinds with whichkey",
                pattern = { "*.rs" },
                callback = function(args)
                    setup_plugin_keybinds(args)
                end
            })

            -- vim.g.rustaceanvim
            local rustaceanvim = { tools=nil, server=nil, dap=nil }

            -- vim.g.rustaceanvim.server.default_settings
            local default_settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            }

            local server = {
                default_settings = default_settings,
                load_vscode_settings = false,
            }

            local tools = {
                code_actions = {
                    ui_select_fallback = false,
                },
                hover_actions = {
                    replace_builtin_hover = false,
                },
            }

            -- Using codelldb for debugging (modified for linux only)
            -- vim.g.rustaceanvim.dap.adapter
            -- local ext_path = "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0"
            -- local adapter = require("rustaceanvim.config").get_codelldb_adapter(
            --     vim.env.HOME .. ext_path .. "/adapter/codelldb",
            --     vim.env.HOME .. ext_path .. "/lldb/lib/liblldb.so"
            -- )

            -- local dap = {
            --     adapter = adapter,
            -- }

            rustaceanvim.server = server
            rustaceanvim.tools = tools
            -- rustaceanvim.dap = dap
            vim.g.rustaceanvim = rustaceanvim
        end
    },
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
