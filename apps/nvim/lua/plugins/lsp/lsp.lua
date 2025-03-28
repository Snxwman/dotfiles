local config_semantic_hl = function(args)
    local lsp = require("util.lsp")
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if client == nil then
        print("Failed to get client")
        return nil
    end

    -- Use the correct highlighting given vim.g.use_semantic_hl
    if client.server_capabilities.semanticTokensProvider then
        if vim.g.use_semantic_hl then
            lsp.use_semantic_hl(bufnr, client.id)    -- BUG: see util.lsp
        else
            lsp.use_treesitter_hl(bufnr, client.id)  -- BUG: see util.lsp
        end
    end
end

local setup_lsp_keybinds = function(args)
    local lsp = require("util.lsp")

    require("which-key").add({
        icon = { icon = "󱃖 ", color = "purple" },
        { "K", vim.lsp.buf.hover, desc = "[LSP] Show symbol info" },
        {
            { "<leader>la", vim.lsp.buf.code_action, desc = "[LSP] Show code actions" },
            { "<leader>lh", vim.lsp.buf.typehierarchy, desc = "[LSP] Show symbol type hierarchy" },
            { "<leader>li", vim.lsp.buf.implementation, desc = "[LSP] Show symbol implementations" },
            { "<leader>lr", vim.lsp.buf.references, desc = "[LSP] Show symbol references" },
            { "<leader>ls", vim.lsp.buf.signature_help, desc = "[LSP] Show signature info" },
            -- Upper case keys for any command that will change something in the buffer
            { "<leader>lR", vim.lsp.buf.rename, desc = "[LSP] Rename symbol" },
            { "<leader>lF", vim.lsp.buf.format, desc = "[LSP] Format buffer" },
            {
                { "<leader>lg", group = "Go to..." },
                { "<leader>lgd", vim.lsp.buf.definition, desc = "[LSP] Go to symbol definition" },
                { "<leader>lgt", vim.lsp.buf.type_definition, desc = "[LSP] Go to type definition" },
            },
            {
                { "<leader>lt", group = "Toggle"},
                { "<leader>ltd", lsp.toggle_diagnostics , desc = "[LSP] Toggle diagnostic" },
                { "<leader>lth", lsp.toggle_hints, desc = "[LSP] Toggle type hints" },
                { "<leader>ltf", vim.diagnostic.open_float, desc = "[LSP] Toggle diagnostic floating window" },
            },
        },
        {
            { "<leader>lC", group = "Manage LSP Client"},
            { "<leader>lCi", vim.lsp.buf.incoming_calls, desc = "[LSP] Incoming calls" },
            { "<leader>lCo", vim.lsp.buf.outgoing_calls, desc = "[LSP] Outgoing calls" },
            { "<leader>lCsk", lsp.kill_semantic_hl, desc = "[LSP] Stop semantic token highlighting PERMANENTLY" },
            {
                { "<leader>lCt", group = "Toggle LSP client features" },
                -- BUG: see util.lsp
                { "<leader>lCts", lsp.toggle_semantic_hl, desc = "[LSP] Toggle semantic token highlighting" },
            },
            { "<leader>lCw", vim.lsp.buf.list_workspace_folders, desc = "[LSP] Show workspace folders" },
            { "<leader>lCI", "<cmd>LspInfo<cr>", desc = "[LSP] Info" },
            { "<leader>lCR", "<cmd>LspRestart<cr>", desc = "[LSP] Restart" },
        },
    })
end

return {
    -- TODO: look into codelens stuff
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp"
    },
    init = function()
        local lsp_attach_augroup = vim.api.nvim_create_augroup("user_lsp_config", { clear = true })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_attach_augroup,
            desc = "Config semantic highlighting",
            callback = function(args)
                config_semantic_hl(args)
            end
        })

        -- Keybinds for base nvim lsp client behavior
        -- Plugin specific keybinds are in their own plugin specs
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_attach_augroup,
            desc = "Setup LSP keybinds with WhichKey",
            once = true,
            callback = function(args)
                setup_lsp_keybinds(args)
            end
        })
    end,
    config = function(_, opts)
        local servers = opts.servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- FIX: All commands are sent to all lsp servers attached to the buffer.
        -- This can cause spurious error messages when less than all of the attached
        -- servers can handle a certain command. 
        -- Possible workaround:
        -- Ensure that no attached lsp servers have overlapping abilities configured.
        -- Known issues:
        --     - Python (basedpyright + ruff) on hover
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = servers["lua_ls"]["settings"],
                        filetypes = (servers["lua_ls"] or {}).filetypes,
                    })
                end,
                ["ruff"] = function()
                    require("lspconfig").ruff.setup({
                        init_options = servers["ruff"]["init_options"],
                        filetypes = (servers["ruff"] or {}).filetypes,
                    })
                end,
                -- handled by rustaceanvim
                ['rust_analyzer'] = function() end,
            },
        })
    end
}

