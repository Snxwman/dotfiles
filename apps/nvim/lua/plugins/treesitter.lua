return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
}
