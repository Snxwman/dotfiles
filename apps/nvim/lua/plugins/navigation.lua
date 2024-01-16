local default_lside_width = 25

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
            "3rd/image.nvim",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                window = {
                    position = "left",
                    width = default_lside_width,
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false,
                    }
                },
                default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
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
                    }
                }
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
                position = "left",
                width = default_lside_width,
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
            }
        }
    },
}
