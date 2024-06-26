return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        { "<leader>ss", "<Esc><cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>sh", "<Esc><cmd>CodeSnapHighlight<cr>", mode = "x", desc = "Save selected code snapshot into clipboard (with line highlighting)" },
        { "<leader>sf", "<Esc><cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot as a file" },
    },
    opts = {
        save_path = "~/media/photos/screenshots/nvim",
        mac_window_bar = false,
        show_workspace = true,
        has_breadcrumbs = true,
        has_line_number = true,
        watermark = "",
        code_font_family = "Berkeley Mono Trial",
        bg_theme = "sea",
    },
}
