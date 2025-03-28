return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function(plugin)
        -- Source: https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/treesitter.lua#L21
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    opts_extend = { "ensure_installed" },
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
