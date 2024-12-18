return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
       "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim"
        },
        opts = {
            ensure_installed = {
                "ansiblels",
                "bashls",
                "clangd",
                "clojure_lsp",
                "cssls",
                "dockerls",
                "docker_compose_language_service",
                "elixirls",
                "fennel_language_server",
                "glsl_analyzer",
                "gopls",
                "html",
                "htmx",
                "jsonls",
                "nil_ls",
                "templ",
                "ts_ls",
                "ltex",
                "lua_ls",
                "marksman",
                "pyright",
                "ruff",
                "rust_analyzer",
                "svelte",
                "tailwindcss",
                "ts_ls"
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp"
        },
        keys = {
            {"K", function() vim.lsp.buf.hover() end, desc = "Display hover hints (LSP)"},
            {"gd", function() vim.lsp.buf.definition() end, desc = "Jump to definition (LSP)"},
            {"<leader>ca", mode = {"n", "v"}, function() vim.lsp.buf.code_action() end, desc = "Show code actions (LSP)"},
            {"<leader>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle inlay hints" },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.ansiblels.setup({ capabilities = capabilities })
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.clojure_lsp.setup({ capabilities = capabilities })
            -- lspconfig.codelldb.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.dockerls.setup({ capabilities = capabilities })
            lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
            lspconfig.elixirls.setup({
                capabilities = capabilities,
                cmd = { "/home/sam/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" };
            })
            lspconfig.fennel_language_server.setup({ capabilities = capabilities })
            lspconfig.glsl_analyzer.setup({})
            lspconfig.gopls.setup({
                capabilities = capabilities,
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
            })
            lspconfig.nil_ls.setup({})
            lspconfig.templ.setup({
                capabilities = capabilities,
                filetypes = { 'templ' },
            })
            lspconfig.htmx.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })
            lspconfig.jsonls.setup({ capabilities = capabilities })
            lspconfig.ts_ls.setup({ capabilities = capabilities })
            lspconfig.ltex.setup({
                capabilities = capabilities,
                filetypes = {"tex"}
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            })
            lspconfig.marksman.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({
                capabilities = capabilities,
                filetypes = {"python"},
            })
            -- lspconfig.rust_analyzer.setup({
            --     settings = {
            --         ["rust_analyzer"] = function() end,
            --     },
            -- })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            require("luasnip.loaders.from_vscode").lazy_load()


            cmp.setup({
                completion = {
                    completeopt = "menu, menuone, preview, noselect, fuzzy"
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                formatting = {
                    fields = { "abbr", "kind", },
                    format = lspkind.cmp_format({
                        maxwidth = 32,
                        ellipsis_char = "…",
                        menu = "",
                    }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                window = {
                    completion = cmp.config.window.bordered({
                        scrollbar = false,
                    }),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- Scroll up and down in the completion documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                })
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = VeryLazy,
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            signs = {
                -- icons / text used for a diagnostic
                error = " ",
                warning = " ",
                hint = " ",
                information = " ",
                other = " ",
            },
        },
    },
    {
        "RRethy/vim-illuminate",
    },
}

