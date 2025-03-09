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
            "mfussenegger/nvim-dap",
            "adaszko/tree_climber_rust.nvim",
        },
        version = "^5",
        enabled = true,
        lazy = false,
        init = function()
            vim.api.nvim_create_autocmd({"BufEnter", "DirChanged"}, {
                -- Slightly less lazy, force starts lsp when the cwd has a Cargo.toml
                callback = function()
                    local lsp_not_started = not vim.g.loaded_rustaceanvim
                    local in_rust_dir = vim.fn.filereadable(vim.fn.getcwd() .. "/Cargo.toml") == 1

                    if lsp_not_started and in_rust_dir then
                        require("rustaceanvim.lsp").start()
                    end
                end,
            })
        end,
        config = function()
            -- vim.g.rustaceanvim
            local rustaceanvim = { tools=nil, server=nil, dap=nil }

            -- vim.g.rustaceanvim.server.on_attach
            local on_attach = function (_, bufnr)
                local map = function (key)  -- mimics the syntax for lazy's keys table
                    key.mode = key.mode or "n"
                    key.desc = key.desc or ""
                    key.desc = "LSP: " .. key.desc .. " (rust)"

                    local opts = { silent = true, buffer = bufnr, desc = key.desc }
                    vim.keymap.set(key.mode, key[1], key[2], opts)
                end

                map({"<leader>bk", "<cmd>RustLsp moveItem up<cr>", desc = "Move block up"})
                map({"<leader>bj", "<cmd>RustLsp moveItem down<cr>", desc = "Move block down"})
                map({"<leader>J", "<cmd>RustLsp joinLines<cr>", desc = "Join selected lines"})
                map({"<leader>ca", "<cmd>RustLsp codeAction<cr>", desc = "Code actions"})
                map({"<leader>dr", "<cmd>RustLsp debuggables<cr>", desc = "Debuggables"})
                map({"<leader>Oc", "<cmd>RustLsp openCargo<cr>", desc = "Open Cargo.toml"})
                map({"<leader>Od", "<cmd>RustLsp openDocs<cr>", desc = "Open web doc for current symbol"})
                map({"K", "<cmd>RustLsp hover actions<CR>", desc = "LSP: Hover actions"})
                map({"s", "<cmd>lua require('tree_climber_rust').init_selection()<CR>", desc = "Tree climber, start selection"})
                map({"s", "<cmd>lua require('tree_climber_rust').select_incremental()<CR>", mode = "x", "Tree climber, increment selection"})
                map({"S", "<cmd>lua require('tree_climber_rust').select_previous()<CR>", mode = "x", "Tree climber, decrement selection"})
            end

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

            -- Using codelldb for debugging (modified for linux only)
            -- vim.g.rustaceanvim.dap.adapter
            local ext_path = "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0"
            local adapter = require("rustaceanvim.config").get_codelldb_adapter(
                vim.env.HOME .. ext_path .. "/adapter/codelldb",
                vim.env.HOME .. ext_path .. "/lldb/lib/liblldb.so"
            )

            local server = {
                on_attach = on_attach,
                default_settings = default_settings,
                load_vscode_settings = false,
            }

            local tools = {
                code_actions = {
                    ui_select_fallback = true,
                },
            }

            local dap = {
                adapter = adapter,
            }

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
