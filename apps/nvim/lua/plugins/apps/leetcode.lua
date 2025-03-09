return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            lang = "rust",
            cache = { update_interval = 86400 },  -- One day in seconds
        },
        config = function(_, opts)
            require('which-key').add({
                {
                    icon = { icon = "󰬓 ", color = "yellow" },
                    { "<leader>L", group = "Leetcode" },
                    { "<leader>Lc", "<cmd>Leet console<cr>", desc = "[Leet] Open console" },
                    { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "[Leet] Submit answer" },
                    { "<leader>Lt", "<cmd>Leet test<cr>", desc = "[Leet] Test answer" },
                },
            })

            require("leetcode").setup(opts)
        end
    },
}
