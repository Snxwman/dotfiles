return {
    -- TODO: look into codelens stuff
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp"
    },
    config = function(_, opts)
        local on_attach = function(client, bufnr)
            local lsp = require("util.lsp")

            -- Use the correct highlighting given vim.g.use_semantic_hl
            if client.server_capabilities.semanticTokensProvider then
                if vim.g.use_semantic_hl then
                    lsp.use_semantic_hl(bufnr, client.id)    -- BUG: see util.lsp
                else
                    lsp.use_treesitter_hl(bufnr, client.id)  -- BUG: see util.lsp
                end
            end

            require("which-key").add({
                {
                    icon = { icon = "󱃖 ", color = "purple" },
                    { "K", vim.lsp.buf.hover, desc = "[LSP] Show symbol info" },
                    { "<leader>la", vim.lsp.buf.code_action, desc = "[LSP] Show code actions" },
                    { "<leader>lh", vim.lsp.buf.typehierarchy, desc = "[LSP] Show symbol type hierarchy" },
                    { "<leader>li", vim.lsp.buf.implementation, desc = "[LSP] Show symbol implementations" },
                    { "<leader>lr", vim.lsp.buf.references, desc = "[LSP] Show symbol references" },
                    { "<leader>ls", vim.lsp.buf.signature_help, desc = "[LSP] Show signature info" },
                    -- Upper case keys for any command that will change something in the buffer
                    { "<leader>lR", vim.lsp.buf.rename, desc = "[LSP] Rename symbol" },
                    { "<leader>lF", vim.lsp.buf.format, desc = "[LSP] Format buffer" },
                    {
                        group = "Go to definition",
                        { "<leader>lgs", vim.lsp.buf.definition, desc = "[LSP] Go to symbol definition", mode = { "n", "v" } },
                        { "<leader>lgt", vim.lsp.buf.type_definition, desc = "[LSP] Go to type definition" },
                    },
                    {
                        group = "Toggle",
                        { "<leader>ltd", lsp.toggle_diagnostics , desc = "[LSP] Toggle diagnostic" },
                        { "<leader>lth", lsp.toggle_hints, desc = "[LSP] Toggle type hints" },
                        { "<leader>ltf", vim.diagnostic.open_float, desc = "[LSP] Toggle diagnostic floating window" },
                    },
                },
                {
                    group = "LSP Server Client",
                    { "<leader>lCi", vim.lsp.buf.incoming_calls, desc = "[LSP] Incoming calls" },
                    { "<leader>lCo", vim.lsp.buf.outgoing_calls, desc = "[LSP] Outgoing calls" },
                    {
                        group = "Toggle features",
                        -- BUG: see util.lsp
                        { "<leader>lCts", lsp.toggle_semantic_hl, desc = "[LSP] Toggle semantic token highlighting" },
                    },
                    { "<leader>lCsk", lsp.kill_semantic_hl, desc = "[LSP] Stop semantic token highlighting PERMANENTLY" },
                    { "<leader>lCw", vim.lsp.buf.list_workspace_folders, desc = "[LSP] Show workspace folders" },
                    { "<leader>lCI", "<cmd>LspInfo<cr>", desc = "[LSP] Info" },
                    { "<leader>lCR", "<cmd>LspRestart<cr>", desc = "[LSP] Restart" },
                },
            })
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
}

