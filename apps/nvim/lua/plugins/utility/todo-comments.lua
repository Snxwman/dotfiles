return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        colors = {
            red = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            orange = { "#FC8D2B" },
            yellow = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            gold = { "DiagnosticWarn", "WarningMsg", "#b48804" },
            green = { "DiagnosticHint", "#10B981" },
            darkgreen = { "#0a715f" },
            blue = { "DiagnosticInfo", "#2563EB" },
            purple = { "Identifier", "#7C3AED" },
            magenta = { "Identifier", "#FF00FF" },
            default = { "Identifier", "#7C3AED" },
        },
        keywords = {
            BUG = { icon = " ", color = "red", alt = { "ISSUE" } },
            CRIT = { icon = "󰞏 ", color = "red", alt = { "CRITICAL" } },
            FIX = { icon = " ", color = "red", alt = { "FIXME", "FIXIT" } },
            GITHUB = { icon = "󰊤 ", color = "green" },
            HACK = { icon = "󰈸 ", color = "orange" },
            -- IDEA = { icon = "󰛨 ", color = "gold" },
            IDEA = { icon = " ", color = "magenta" },
            NOTE = { icon = " ", color = "green", alt = { "INFO" } },
            PERF = { icon = "󱐋 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            QUESTION = { icon = "󰠗 ", color = "darkgreen" },
            TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            TODO = { icon = " ", color = "blue" },
            WARN = { icon = " ", color = "yellow", alt = { "WARNING", "XXX" } },
        },
        highlight = {
            -- TODO: Multilines must be indented 3 (1+2) spaces to prevent unrelated 
            --   comments getting included in the multiline comment
            --   eg. valid multiline continuation
            -- eg. invalid multiline continuation
            multiline_pattern = "^.",
            multiline_context = 25,
        },
        merge_keywords = true,
    },
}
