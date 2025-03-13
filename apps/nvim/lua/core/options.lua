vim.g.have_nerd_font = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Visual
vim.opt.colorcolumn = { 80, 120 }
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.breakindent = true

vim.opt.list = false
vim.opt.listchars = { trail = "", nbsp = "␣", }

vim.opt.hlsearch = true

-- State
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Window title
vim.opt.title = true
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function (opts)
        vim.schedule(function()
            local term = vim.fn.environ().TERM:gsub("xterm%-", ""):gsub("^%l", string.upper)
            local app_filetypes = { "dashboard", "leetcode.nvim" }

            local file = vim.fn.expand("%:p:h")
            local filetype = vim.bo[opts.buf].filetype

            for _, app in ipairs(app_filetypes) do
                if filetype == app then
                    file = filetype
                    vim.opt.titlestring = term .. " [nvim] " .. file
                    return
                end
            end

            file = file:gsub(vim.fn.getenv("HOME"), "~")

            vim.opt.titlestring = term .. " [nvim] " .. file
        end)
    end
})

