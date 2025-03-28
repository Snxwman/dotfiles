return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
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
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({})
                }
            }
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        opts = {},
        config = function(_, _)
            require("telescope").load_extension("ui-select")
        end
    }
}
