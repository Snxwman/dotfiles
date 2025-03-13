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
        triggers = {
            { "<auto>", mode = "nxso" },
            { "<C>", mode = { "n", "v", "i", "o" } },
            { "<M>", mode = "nvio" },
            { "<D>", mode = "nvio" },
        },
        ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
        delay = function(ctx)
            -- local modKey = 
            return ctx.plugin and 0 or 100
        end,
        spec = {
            { "<leader>e", group = "Explorer",      icon = { icon = " ", color = "yellow" } },
            { "<leader>f", group = "File",          icon = { icon = " ", color = "yellow" } },
            { "<leader>b", group = "Buffer",        icon = { icon = " ", color = "red"    } },
            { "<leader>w", group = "Window",        icon = { icon = " ", color = "blue"   } },
            { "<leader>a", group = "AI",            icon = { icon = " ", color = "red"    } },
            { "<leader>l", group = "LSP",           icon = { icon = "󱃖 ", color = "purple" } },
            { "<leader>g", group = "Git",           icon = { icon = " ", color = "orange" } },
            { "<leader>n", group = "Notifications", icon = { icon = " ", color = "yellow" } },
            { "<leader>t", group = "Toggle",        icon = { icon = " ", color = "green"  } },
            { "<leader>x", group = "Trouble",       icon = { icon = "󰔫 ", color = "orange" } },
            { "<leader>v", group = "Neovim",        icon = { icon = " ", color = "green" } },
            { "<leader>u", group = "Utilities",     icon = { icon = " ", color = "cyan"   } },

            { "<leader>?", "<cmd>WhichKey<cr>", icon = "󱍊 " },
        },
        icons = {
            rules = {
                -- { pattern = "[LSP]", icon = "" },
                { pattern = "rust", icon = "", color = "orange" },
            },
        },
        expand = function (node)
            local maxChildren = 2
            return node:count() < maxChildren or not node.desc
        end,
        sort = { "order", "group", "manual", "alphanum", "mod" },
        win = {
            wo = { winblend = 20 }
        },
        layout = {
            -- max = 100
        },
        ---@type number|fun(node: wk.Node):boolean?
    },
}
