require("core")
require("config.lazy")

-- vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
-- vim.fn.sign_define("DiagnosticSignWarn",  {text = " ", texthl = "DiagnosticSignWarn"})
-- vim.fn.sign_define("DiagnosticSignInfo",  {text = " ", texthl = "DiagnosticSignInfo"})
-- vim.fn.sign_define("DiagnosticSignHint",  {text = "󰌵 ", texthl = "DiagnosticSignHint"})

--[[
vim.api.nvim_create_autocmd("VimEnter", {
    command = "Outline"
})
vim.api.nvim_create_autocmd("VimEnter", {
    command = "Neotree filesystem reveal_force_cwd left",
})
--]]



vim.filetype.add {
    extension = {
        zsh = "sh",
        sh = "sh",
    },
    filename = {
        [".zshrc"] = "sh",
        [".zshenv"] = "sh",
    }
}
