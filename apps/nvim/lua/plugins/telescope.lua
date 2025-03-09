return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
                "nvim-lua/plenary.nvim",
        },
        keys = function()
            local builtin = require("telescope.builtin")

            require("which-key").add({
                { "<leader>fg", builtin.live_grep, desc = "[Telescope] grep files" },
                { "<C-p>", builtin.find_files, desc = "[Telescope] find files" },
            })
        end,
        opts = {
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    sort_mru = true,
                    theme = "dropdown",
                },
                find_files = {
                    theme = "dropdown",
                    hidden = true,
                }
            }
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        opts = {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                }
            }
        },
        config = function(_, _)
            require("telescope").load_extension("ui-select")
        end
    }
}
