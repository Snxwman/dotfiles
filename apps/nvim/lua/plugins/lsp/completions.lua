return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "chrisgrieser/cmp-nerdfont",

            "onsails/lspkind.nvim",
        },
        config = function()
            local log = require("plenary.log").new({
                plugin = "cmp",
                level = "debug",
            })

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                -- performance = { max_view_entries = 5 },
                -- enabled = function()
                --     if cmp.config.context ~= nil then
                --         return not cmp.config.context.in_syntax_group("Comment")
                --             and not cmp.config.context.in_treesitter_capture("comment")
                --     else
                --         return true
                --     end
                -- end,

                sources = cmp.config.sources({
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp", group_index = 1,
                        entry_filter = function(entry, _)
                            return entry:get_kind() ~= 15  -- Filter out lsp snippets
                        end
                    },
                    { name = "luasnip", group_index = 2 },
                    { name = "buffer", group_index = 2 },
                    { name = "path", group_index = 2 },
                    { name = "emoji", keyword_length = 2 },
                    { name = "nerdfont", keyword_length = 2 },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.sort_text
                    },
                },
                completion = {
                    completeopt = "menu, menuone, preview, noselect, fuzzy"
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                view = {
                    entries = { name = 'custom', selection_order = 'near_cursor' }
                },
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -4,   -- Where the menu starts, relative to cursor
                        side_padding = 0,  -- Prevents the selection line color from going off the edge
                        scrollbar = false,
                    }),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        local src_tag = ({
                            lazydev  = "[LAZY] ",
                            nvim_lsp = " [LSP] ",
                            luasnip  = "[SNIP] ",
                            buffer   = " [BUF] ",
                            path     = "[PATH] ",
                            emoji    = "[EMJI] ",
                            nerdfont = "[NERD] ",
                            git      = " [GIT] ",
                        })[entry.source.name]
                        src_tag = src_tag or "   [?] "

                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = {
                                menu = 50,  -- TODO: Make a function based on the window size
                            },
                            ellipsis_char = "…",
                        })

                        local cmp_detail = entry.completion_item.detail
                        local fields = kind(entry, item)
                        local strings = vim.split(fields.kind, "%s", { trimempty = true })
                        local icon, src_desc = (strings[1] or "?"), (strings[2] or "?")
                        local details = ""
                        local autoimport = ""

                        if cmp_detail then
                            if cmp_detail == "Auto-import" then
                                autoimport = "󰋺 "
                            else
                                details = cmp_detail
                            end
                        end

                        fields.kind = " " .. icon .. " "
                        fields.menu = "\t" .. src_tag .. autoimport .. src_desc .. " " .. details

                        return fields
                    end,
                },
                -- experimental = {  -- TODO: toggle this on/off when not inside a word
                --     ghost_text = true,
                -- },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),
                })
                -- TODO: cmdline config
            })

            -- TODO: put somewhere else
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    require("cmp")
                    local function get_hl(name)
                        local hl = vim.api.nvim_get_hl(0, { name = name })
                        while hl and hl.link do
                            local link = hl.link
                            hl = vim.api.nvim_get_hl(0, { name = link })
                        end
                        return hl
                    end

                    local function swap_hl_colors(hl_name)
                        local hl_info = get_hl(hl_name)

                        local color = type(hl_info.fg) == "number" and string.format("#%06x", hl_info.fg) or ""
                        local new_hl = {}
                        new_hl.bg = color
                        return new_hl
                    end

                    local function set_inverted_hl_groups(hl1, text)
                        local hl_inv = swap_hl_colors(hl1)
                        if type(hl_inv) == "table" then
                            hl_inv.fg = string.format("#%06x", text.bg)   -- Set new foreground to hl2's foreground
                            vim.api.nvim_set_hl(0, hl1, hl_inv)
                            -- CmpItemAbbrMatch
                            -- CmpItemAbbrMatchFuzzy
                            -- FIX: CmpItemKindText (too dark)
                        end
                    end

                    local cmpKinds = require("cmp.types.lsp")
                    for kind in pairs(cmpKinds.CompletionItemKind) do
                        if type(kind) == "string" then
                            local name = ("CmpItemKind%s"):format(kind)
                            set_inverted_hl_groups(name, get_hl("Pmenu"))
                        end
                    end
                end
            })
        end
    },
}
