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
                    { name = "emoji", keyword_length = 3 },
                    { name = "nerdfont", keyword_length = 3 },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.recently_used,
                        cmp.config.compare.exact,
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

                        fields.dup = ({
                            buffer = 0,
                        })[entry.source.name] or 0

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
                    local color = require("util.color")

                    local function get_hl_group(name)
                        local hl = vim.api.nvim_get_hl(0, { name = name })

                        while hl and hl.link do
                            local link = hl.link
                            hl = vim.api.nvim_get_hl(0, { name = link })
                        end

                        return hl
                    end

                    local function hex(c)
                        if type(c) == "number" then
                            return string.format("#%06x", c)
                        end
                    end

                    local function new_hl(hl)
                        local nhl = {
                            bg = hex(hl.bg),
                            fg = hex(hl.fg),
                            sp = hex(hl.sp),
                            bold = hl.bold,
                            underline = hl.underline,
                            italic = hl.italic,
                        }
                        return nhl
                    end

                    local function swap_fg_bg(hl_name)
                        local hl = new_hl(get_hl_group(hl_name))
                        local bg = hl.bg
                        hl.bg = hl.fg
                        hl.fg = bg
                        return hl
                    end

                    local function set_inverted_hl_group(hl_name, fg_hl)
                        local kind_hl = swap_fg_bg(hl_name)
                        if type(kind_hl) == "table" then
                            kind_hl.fg = hex(fg_hl.fg)
                            vim.api.nvim_set_hl(0, hl_name, kind_hl)
                        end
                    end

                    local function set_dark_hl_group(hl_name, bg_hl)
                        local kind_hl = new_hl(get_hl_group(hl_name))
                        if type(kind_hl) == "table" then
                            kind_hl.bg = color.mix(hex(bg_hl.fg), "#000000", 50)
                            vim.api.nvim_set_hl(0, hl_name, kind_hl)
                        end
                    end

                    local function set_atom_hl_group(hl_name)
                        local kind_hl = new_hl(get_hl_group(hl_name))
                        if type(kind_hl) == "table" then
                            if kind_hl.fg then
                                kind_hl.bg = color.mix(kind_hl.fg, "#000000", 70)
                            else
                                local pmenu_hl = new_hl(get_hl_group("Pmenu"))
                                kind_hl.bg = color.mix(pmenu_hl.fg, "#000000", 70)
                            end
                            vim.api.nvim_set_hl(0, hl_name, kind_hl)
                        end
                    end

                    local style = "atom"
                    local cmp_kinds = require("cmp.types.lsp")
                    for kind in pairs(cmp_kinds.CompletionItemKind) do
                        if type(kind) == "string" then
                            local hl_name = "CmpItemKind" .. kind

                            if style == "dark" then
                                -- Dark bg, colored fg
                                set_dark_hl_group(hl_name, get_hl_group("CmpItemMenu"))
                            elseif style == "atom" then
                                set_atom_hl_group(hl_name)
                            else
                                -- Colored bg, darg fg
                                set_inverted_hl_group(hl_name, get_hl_group("CmpItemMenu"))
                            end
                        end
                    end

                    local abbr_match_hl = new_hl(get_hl_group("CmpItemAbbrMatch"))
                    abbr_match_hl.bold = true
                    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", abbr_match_hl)
                end
            })
        end
    },
}
