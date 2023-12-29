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

opt.number = true
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

require("lazy").setup("plugins")

