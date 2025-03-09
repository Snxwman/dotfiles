return {
    {
        "ziontee113/icon-picker.nvim",
        dependencies = {
            "stevearc/dressing.nvim",
        },
        keys = function()
            require("which-key").add({
                {
                    icon = { icon = " " },
                    {"<leader>ui", group = "Icon Picker" },
                    {"<leader>uin", "<cmd>IconPickerYank nerd_font_v3<cr>", desc = "[Icon Picker] normal"},
                    {"<leader>uiy", "<cmd>IconPickerYank nerd_font_v3<cr>", desc = "[Icon Picker] yank"},
                    {"<leader>uiI", "<cmd>IconPickerInsert nerd_font_v3<cr>", desc = "[Icon Picker] insert)"},
                }
            })
        end,
        opts = {
            disable_legacy_commands = true,
        },
    },
--[[
    {
        --"snxwman/icon-picker.nvim",
        --branch = "gen-nf-v3-icon-list",
        dir = "~/src/github/icon-picker.nvim/",
        enabled = true,
        config = function()
            require("icon-picker").setup({ disable_legacy_commands = true })

            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<Leader>i", "<cmd>IconPickerNormal nerd_font_v3<cr>", opts)
            vim.keymap.set("n", "<Leader>y", "<cmd>IconPickerYank nerd_font_v3<cr>", opts)
            vim.keymap.set("i", "<M-i>", "<cmd>IconPickerInsert nerd_font_v3<cr>", opts)
        end
    }
--]]
}
