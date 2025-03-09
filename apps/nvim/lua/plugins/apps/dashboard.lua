return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            change_to_vcs_root = true,
            hide = {
                statusline = false,
            },
            config = {
                disable_move = true,
                header = {
                    os.date("Today is %A, %B %d, %Y\nThe time is %H:%M:%S")
                },
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = "󰊳 Update",
                        group = "@property",
                        action = "Lazy update",
                        key = "u"
                    },
                    {
                        icon_hl = "@variable",
                        desc = " Files",
                        group = "Label",
                        action = "Telescope find_files",
                        key = "f",
                    },
                    {
                        desc = " Apps",
                        group = "DiagnosticHint",
                        action = "Telescope app",
                        key = "a",
                    },
                    {
                        desc = " dotfiles",
                        group = "Number",
                        action = "Telescope dotfiles",
                        key = "d",
                    },
                },
                project = {
                    limit = 5,
                },
                mru = {
                    limit = 5,
                },
                footer = {

                },
            },
        })
    end,
}
