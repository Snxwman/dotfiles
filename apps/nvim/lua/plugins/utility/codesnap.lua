return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    cmd = { "CodeSnap", "CodeSnapHighlight", "CodeSnapSave" },
    keys = function(_, _)
        require("which-key").add({
            {
                { "<leader>us", group = "Screenshot" },
                icon = { icon = " " },
                { "<leader>usc", "<Esc><cmd>CodeSnap<cr>",
                    desc = "[Codesnap] Save to clipboard" },
                { "<leader>usC", "<Esc><cmd>CodeSnapHighlight<cr>",
                    desc = "[Codesnap] Save to clipboard (line highlights)" },
                { "<leader>usf", "<Esc><cmd>CodeSnapSave<cr>",
                    desc = "[Codesnap] Save to file" },
            }
        })
    end,
    opts = {
        save_path = "~/media/photos/screenshots/nvim",
        mac_window_bar = false,
        show_workspace = true,
        has_breadcrumbs = true,
        has_line_number = true,
        watermark = "",
        code_font_family = "Berkeley Mono",
        bg_theme = "sea",
    },
}
