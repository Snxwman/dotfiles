return {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = function(_, _)
        require("which-key").add({
            {
                { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" }
            }
        })
    end,
}
