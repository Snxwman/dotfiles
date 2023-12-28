local opt = vim.opt

-- indentation
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4

-- visual
opt.colorcolumn = { 80, 100, 130 }

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.relativenumber = true

opt.cursorline = true

-- Keys
vim.g.mapleader = " "


-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} }
}

local opts = {}

require("lazy").setup(plugins, opts)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- treesitter
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {
        "bash", 
        "c", 
        "cmake",
        "commonlisp", 
        "cpp",
        "css", 
        "csv",
        "dockerfile",
        "fennel",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gpg",
        "html",
        "ini",
        "java",
        "javascript", 
        "jq",
        "json",
        "json5",
        "latex",
        "lua", 
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "passwd",
        "pem",
        "rasi",
        "rust",
        "sql",
        "ssh_config",
        "sxhkdrc",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "yuck",
    },
    highlight = { enable = true },
    indent = { enable = true},
})

-- theme
require("tokyonight").setup({
    style = "night"
})
vim.cmd.colorscheme "tokyonight"
