return {
    "folke/which-key.nvim",
    dependencies = {
        "echasnovski/mini.icons"
    },
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        preset = "modern",
        spec = {
            { "<leader>a", group = "AI",            icon = { icon = " ", color = "red"    } },
            { "<leader>e", group = "Explorer",      icon = { icon = " ", color = "yellow" } },
            { "<leader>l", group = "LSP",           icon = { icon = "󱃖 ", color = "purple" } },
            { "<leader>n", group = "Notifications", icon = { icon = " ", color = "yellow" } },
            -- { "<leader>s", group = "Screenshot",    icon = { icon = " ", color = "orage"  } },
            { "<leader>t", group = "Toggle",        icon = { icon = " ", color = "green"  } },
            { "<leader>u", group = "Utilities",     icon = { icon = " ", color = "cyan"   } },
            { "<leader>w", group = "Window",        icon = { icon = " ", color = "blue"   } },
            { "<leader>x", group = "Trouble",       icon = { icon = "󰔫 ", color = "orange" } },
        },
        icons = {
            rules = {
                -- { pattern = "[LSP]", icon = "" },
                { pattern = "rust", icon = "", color = "orange" },
            },
        },
    },
}
