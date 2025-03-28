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
