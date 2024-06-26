return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        enabled = true,
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
        },
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                server = {
                }
            }
        end
    },
}
