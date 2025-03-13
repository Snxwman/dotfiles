local default_rside_width = 50

return {
    "hedyhli/outline.nvim",
    enabled = true,
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = function(_, _)
        require("which-key").add({
            {
                { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle symbol outline" },
            }
        })
    end,
    opts = {
        outline_window = {
            position = "right",
            width = default_rside_width,
            relative_width = false,
            focus_on_open = false,
            auto_close = true,
            show_cursorline = true,
        },
        outline_items = {
            show_symbol_lineno = true,
        },
        keymaps = {
            close = {},
        },
        symbols = {
            icons = {
                Array           = { icon = "󰅪 ", hl = "Constant" },     -- Could be better (󰀻  󰁥  )
                Boolean         = { icon = "󰨙 ", hl = "Boolean" },
                Class           = { icon = " ", hl = "Type" },
                Component       = { icon = " ", hl = "Function" },     -- Could be better
                Constant        = { icon = "󰏿 ", hl = "Constant" },     -- Could be better ( 󰗝 )
                Constructor     = { icon = " ", hl = "Special" },
                Enum            = { icon = " ", hl = "Type" },
                EnumMember      = { icon = " ", hl = "Identifier" },
                Event           = { icon = " ", hl = "Type" },
                Field           = { icon = "󰓹 ", hl = "Identifier" },
                File            = { icon = "󰈙 ", hl = "Identifier" },
                Fragment        = { icon = " ", hl = "Constant" },     -- Could be better
                Function        = { icon = " ", hl = "Function" },
                Interface       = { icon = " ", hl = "Type" },         -- Could be better ( 󱘖 󰟩  󱔛 )
                Key             = { icon = "󰌋 ", hl = "Type" },
                Macro           = { icon = " ", hl = "Function" },     -- Could be better
                Method          = { icon = "󰡱 ", hl = "Function" },
                Module          = { icon = " ", hl = "Include" },
                Namespace       = { icon = "󰅪 ", hl = "Include" },      -- Could be better
                Null            = { icon = " ", hl = "Type" },         -- Could be bettr ( 󱨧 )
                Number          = { icon = " ", hl = "Number" },
                Object          = { icon = "󰘦 ", hl = "Type" },         -- Could be better
                Operator        = { icon = " ", hl = "Identifier" },
                Package         = { icon = "󰏗 ", hl = "Include" },
                Parameter       = { icon = " ", hl = "Identifier" },   -- Could be better
                Property        = { icon = "󰓹 ", hl = "Identifier" },
                StaticMethod    = { icon = " ", hl = "Function" },     -- Could be better
                String          = { icon = "󱀍 ", hl = "String" },       -- Tossup ()
                Struct          = { icon = "󰙅 ", hl = "Structure" },    -- Could be better
                TypeAlias       = { icon = "󰴂 ", hl = "Type" },         -- Could be better
                TypeParameter   = { icon = " ", hl = "Identifier" },
                Variable        = { icon = "󰀫 ", hl = "Constant" },     -- Could be better
            },
        },
    }
}
