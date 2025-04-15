local default_lside_width = 25

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim",
    },
    lazy = false,
    cmd = "Neotree",
    init = function()
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN]  = " ",
                    [vim.diagnostic.severity.INFO]  = " ",
                    [vim.diagnostic.severity.HINT]  = "󰌵 ",
                },
                -- linehl = {
                --     [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                --     [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
                --     [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
                --     [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
                -- },
            },
        })
    end,
    keys = function(_, _)
        require("which-key").add({
            {
                { "<leader>te", "<cmd>Neotree filesystem reveal left toggle<cr>",
                    desc = "[Neotree] Toggle explorer"},
                { "<C-f>", "<cmd>Neotree focus<cr>", desc = "[Neotree] focus"}
            }
        })
    end,
    opts = {
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
                }
            }
        }
    }
}
