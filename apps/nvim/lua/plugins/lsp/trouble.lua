return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Trouble" },
    keys = function()
        require("which-key").add({
            { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "[Trouble] diagnostics (current buffer)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",
                desc = "[Trouble] diagnostics (all files)" },
            { "<leader>xt", "<cmd>Trouble todo toggle filter.buf=0<cr>",
                desc = "[Trouble] todo (current buffer)" },
            { "<leader>xT", "<cmd>Trouble todo toggle<cr>",
                desc = "[Trouble] todo (all files)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle",
                desc = "[Trouble] quickfix list"},
        })
    end,
    opts = {
        signs = {
            -- icons / text used for a diagnostic
            error = " ",
            warning = " ",
            hint = " ",
            information = " ",
            other = " ",
        },
    },
}
