return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async"
    },
    keys = function()
        local peekFold = function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end

        require("which-key").add({
            { "zR", require("ufo").openAllFolds, desc = "[UFO] Open all folds" },
            { "zM", require("ufo").closeAllFolds, desc = "[UFO] Close all folds" },
            { "zK", peekFold, desc = "[UFO] Peek fold" }
        })
    end,
    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            return { "lsp", "indent" }
        end
    },
    config = function(opts)
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require("ufo").setup(opts)
    end
}
