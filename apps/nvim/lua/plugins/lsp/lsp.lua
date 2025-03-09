return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function(_, opts)
            -- This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(_, bufnr)
                local map = vim.keymap.set
                local nv = { "n", "v" }

                local hover = function() vim.lsp.buf.hover() end
                local goto_def = function() vim.lsp.buf.definition() end
                local actions = function() vim.lsp.buf.code_action() end
                local toggle_hints = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end
                local rename = function() vim.lsp.buf.rename() end

                map("n", "K", hover, { desc = "[LSP] Hover"} )
                map("n", "gd", goto_def, {desc = "[LSP] Go to definition"})
                map(nv, "<leader>ca", actions, { desc = "[LSP] Show code actions"})
                map("n", "<leader>h", toggle_hints, { desc = "[LSP] Toggle inlay hints" })
                map("n", "<leader>lr", rename, {desc = "[LSP] Rename Symbol"})
                map("n", "<leader>lI", "<cmd>LspInfo<cr>", { desc = "[LSP] Info" })
                map("n", "<leader>lR", "<cmd>LspRestart<cr>", {desc = "[LSP] Restart"})
            end

            local servers = opts.servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name)
                        local settings = servers[server_name]
                        if server_name == "lua_ls" then
                            settings = servers[server_name]["settings"]
                        end

                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = settings,
                            filetypes = (servers[server_name] or {}).filetypes,
                        })
                    end,
                },
            })
        end
    },
}

