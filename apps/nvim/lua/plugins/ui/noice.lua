return {
    "folke/noice.nvim",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    keys = function()
        require("which-key").add({
            {
                icon = { icon = " ", color = "yellow" },
                {"<leader>na", "<cmd>NoiceAll<cr>", desc = "[Noice] Show all messages"},
                {"<leader>nd", "<cmd>NoiceDismiss<cr>", desc = "[Noice] Dismiss all messages"},
                {"<leader>ne", "<cmd>NoiceErrors<cr>",  desc = "[Noice] Show errors"},
                {"<leader>nh", "<cmd>NoiceHistory<cr>", desc = "[Noice] Show history"},
            }
        })
    end,
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            hover = {
                silent = true,
            },
        },
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
    },
}
