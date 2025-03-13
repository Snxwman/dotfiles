return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-n>",
                node_incremental = "<C-n>",
                node_decremental = "<C-m>",
                scope_incremental = "<C-s>",
            },
        },
        ensure_installed = {
            "csv",
            "gpg",
            "ini",
            "make",
            "passwd",
            "pem",
            "rasi",
            "regex",
            "ssh_config",
            "sxhkdrc",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "yuck",  -- TODO: put somwhere else
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
