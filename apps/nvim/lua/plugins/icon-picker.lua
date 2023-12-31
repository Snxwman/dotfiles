return {
    "ziontee113/icon-picker.nvim",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<Leader>i", "<cmd>IconPickerNormal nerd_font_v3<cr>", opts)
        vim.keymap.set("n", "<Leader>y", "<cmd>IconPickerYank nerd_font_v3<cr>", opts)
        vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert nerd_font_v3<cr>", opts)
    end
}
