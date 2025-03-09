return {
    "NvChad/nvim-colorizer.lua",
    opts = {
        user_default_options = {
            names = false,
            css = true,
            sass = {
                enable = true,
                parsers = { "css" },
            },
            tailwind = "both",
            always_update = true,
        },
        filetypes = {
            "*",
            css = { names = true },
            html = { names = true },
            scss = { names = true },
        },
    },
}
