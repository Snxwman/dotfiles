local default_lside_width = 25
local default_rside_width = 50

return {
    {
        "ThePrimeagen/harpoon",
        --[[ 
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        ]]--
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file, {desc = 'Add Mark'})
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-1>", function () ui.nav_file(1) end)
            vim.keymap.set("n", "<C-2>", function () ui.nav_file(2) end)
            vim.keymap.set("n", "<C-3>", function () ui.nav_file(3) end)
            vim.keymap.set("n", "<C-4>", function () ui.nav_file(4) end)
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim",
        },
        config = function()
            vim.fn.sign_define("DiagnosticSignError",
                {text = " ", texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn",
                {text = " ", texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo",
                {text = " ", texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint",
                {text = "󰌵", texthl = "DiagnosticSignHint"})

            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                window = {
                    position = "left",
                    width = default_lside_width,
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false,
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                },
                mappings = {
                    ["a"] = { "add", config = { show_path = "relative" } },
                },
                default_component_configs = {
                    indent = {
                        padding = 0,
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                        default = "󰈔",
                    },
                    modified = {
                        symbol = "",
                        highlight = "NeoTreeModified",
                    },
                    git_status = {
                        symbols = {
                            untracked = "",
                            ignored = "",
                            staged = "",
                        },
                    },
                },
            })

            vim.keymap.set("n", "<C-f>", ":Neotree filesystem reveal_force_cwd left<CR>", {})
        end
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
        end
    },
    {
        "hedyhli/outline.nvim",
        enabled = true,
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            {"<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
        },
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
                    Array           = { icon = '󰅪 ', hl = 'Constant' },     -- Could be better (󰀻  󰁥  )
                    Boolean         = { icon = '󰨙 ', hl = 'Boolean' },
                    Class           = { icon = ' ', hl = 'Type' },
                    Component       = { icon = ' ', hl = 'Function' },     -- Could be better
                    Constant        = { icon = '󰏿 ', hl = 'Constant' },     -- Could be better ( 󰗝 )
                    Constructor     = { icon = ' ', hl = 'Special' },
                    Enum            = { icon = ' ', hl = 'Type' },
                    EnumMember      = { icon = ' ', hl = 'Identifier' },
                    Event           = { icon = ' ', hl = 'Type' },
                    Field           = { icon = '󰓹 ', hl = 'Identifier' },
                    File            = { icon = '󰈙 ', hl = 'Identifier' },
                    Fragment        = { icon = ' ', hl = 'Constant' },     -- Could be better
                    Function        = { icon = ' ', hl = 'Function' },
                    Interface       = { icon = ' ', hl = 'Type' },         -- Could be better ( 󱘖 󰟩  󱔛 )
                    Key             = { icon = '󰌋 ', hl = 'Type' },
                    Macro           = { icon = ' ', hl = 'Function' },     -- Could be better
                    Method          = { icon = '󰡱 ', hl = 'Function' },
                    Module          = { icon = ' ', hl = 'Include' },
                    Namespace       = { icon = '󰅪 ', hl = 'Include' },      -- Could be better
                    Null            = { icon = ' ', hl = 'Type' },         -- Could be bettr ( 󱨧 )
                    Number          = { icon = ' ', hl = 'Number' },
                    Object          = { icon = '󰘦 ', hl = 'Type' },         -- Could be better
                    Operator        = { icon = ' ', hl = 'Identifier' },
                    Package         = { icon = '󰏗 ', hl = 'Include' },
                    Parameter       = { icon = ' ', hl = 'Identifier' },   -- Could be better
                    Property        = { icon = '󰓹 ', hl = 'Identifier' },
                    StaticMethod    = { icon = ' ', hl = 'Function' },     -- Could be better
                    String          = { icon = '󱀍 ', hl = 'String' },       -- Tossup ()
                    Struct          = { icon = '󰙅 ', hl = 'Structure' },    -- Could be better
                    TypeAlias       = { icon = '󰴂 ', hl = 'Type' },         -- Could be better
                    TypeParameter   = { icon = ' ', hl = 'Identifier' },
                    Variable        = { icon = '󰀫 ', hl = 'Constant' },     -- Could be better
                },
            },
        }
    },
}
