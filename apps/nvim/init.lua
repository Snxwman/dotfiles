require("core")
require("config.lazy")

vim.filetype.add({
    extension = {
        zsh = "sh",
        sh = "sh",
    },
    filename = {
        [".zshrc"] = "sh",
        [".zshenv"] = "sh",
    }
})

vim.filetype.add({
    filename = {
        [".sxhkdrc"] = "sxhkdrc",
    }
})
