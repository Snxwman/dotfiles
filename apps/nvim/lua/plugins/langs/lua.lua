return {
    {
        "folke/lazydev.nvim",
        opts = {
            library = {},
        },
        ft = "lua",
    },
    {   -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
        enabled = false,
        lazy = false, -- lazy loading handled internally
        version = '0.7.6',
        opts = {
            sources = {
                -- add lazydev to your completion providers
                default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            },
            providers = {
                -- dont show LuaLS require statements when lazydev has items
                lazydev = { fallbacks = { "lsp" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            },
        },
    },
}
