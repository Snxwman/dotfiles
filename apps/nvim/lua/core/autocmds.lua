vim.api.nvim_create_autocmd("BufEnter", {
    callback = function (opts)
        vim.schedule(function()
            local term = vim.fn.environ().TERM:gsub("xterm%-", ""):gsub("^%l", string.upper)
            local app_filetypes = { "dashboard", "leetcode.nvim" }

            local file = vim.fn.expand("%:p:h")
            local filetype = vim.bo.filetype

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

vim.api.nvim_create_autocmd( "BufWritePre", {
    group = vim.api.nvim_create_augroup('strip_whitespace', { clear = true }),
    desc = "Strip all trailing whitespace in the buffer on write and restore cursor position.",
    pattern = '<buffer>',
    callback = function(_)
        local cursor_pos = vim.fn.getpos(".")
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.setpos(".", cursor_pos)
    end,
})
