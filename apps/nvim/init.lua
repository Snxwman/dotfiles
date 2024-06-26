local opt = vim.opt

vim.g.have_nerd_font = true

-- Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- indentation
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4

-- visual
opt.colorcolumn = { 80, 100, 130 }
opt.signcolumn = "yes"

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.number = true
opt.relativenumber = true

opt.cursorline = true

opt.breakindent = true

opt.list = true
opt.listchars = { trail = "", nbsp = "␣", }

vim.opt.hlsearch = true

-- State
opt.clipboard = "unnamedplus"
opt.undofile = true

opt.ignorecase = true
opt.smartcase = true

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

require("lazy").setup("plugins")

vim.cmd("colorscheme tokyonight")

vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",  {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",  {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",  {text = "󰌵 ", texthl = "DiagnosticSignHint"})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--[[
vim.api.nvim_create_autocmd("VimEnter", {
    command = "Outline"
})
vim.api.nvim_create_autocmd("VimEnter", {
    command = "Neotree filesystem reveal_force_cwd left",
})
--]]

