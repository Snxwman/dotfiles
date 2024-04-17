local leet_arg = "leetcode.nvim"

return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = leet_arg ~= vim.fn.argv()[1],
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {

    },
    opts = {
        arg = leet_arg,
        lang = "python3",
        directory = vim.fn.stdpath("data") .. "/leetcode/",
        logging = true,
        cache = { update_interval = 86400 }  -- One day in seconds
    },
}
