return {
    -- { "NLKNguyen/papercolor-theme", name = "[Theme] papercolor", lazy = true },
    -- { "ayu-theme/ayu-vim", name = "[Theme] ayu", lazy = true },
    -- { "zootedb0t/citruszest.nvim", name = "[Theme] citruszest", lazy = true },
    -- { "jaredgorski/SpaceCamp", name = "[Theme] spacecamp", lazy = true },
    -- { "safv12/andromeda.vim", name = "[Theme] andromeda", lazy = true },
    -- { "bratpeki/truedark-vim", name = "[Theme] truedark", lazy = true },
    -- { "justb3a/vim-smarties", name = "[Theme] smarties", lazy = true },
    -- { "daltonmenezes/aura-theme", name = "[Theme] aura-dark", lazy = true },
    -- { "rwxmad/spacecat.nvim", name = "[Theme] spacecat", lazy = true },
    -- { "luisiacc/the-matrix.nvim", name = "[Theme] Matrix", lazy = true },
    -- { "arsham/arshamiser.nvim", name = "[Theme] arshamiser", lazy = true },
    -- { "ptdewey/darkearth-nvim", name = "[Theme] darkearth", lazy = true },
    -- { "2giosangmitom/nightfall.nvim", name = "[Theme] nightfall", lazy = true },
    -- { "pauchiner/pastelnight.nvim", name = "[Theme] pastelnight", lazy = true },
    -- { "samharju/synthweave.nvim", name = "[Theme] synthweave", lazy = true },
    -- { "xero/evangelion.nvim", name = "[Theme] evangelion", lazy = true },
    -- { "blazkowolf/gruber-darker.nvim", name = "[Theme] gruber-darker", lazy = true },
    -- { "yorumicolors/yorumi.nvim", name = "[Theme] yorumi", lazy = true },
    -- { "uloco/bluloco.nvim", name = "[Theme] bluloco", lazy = true },
    -- { "rockerBOO/boo-colorscheme-nvim", name = "[Theme] boo", lazy = true },
    -- { "dasupradyumna/midnight.nvim", name = "[Theme] midnight", lazy = true },
    -- { "kartikp10/noctis.nvim", name = "[Theme] noctis", lazy = true },
    -- { "vague2k/vague.nvim", name = "[Theme] vague", lazy = true },

    -- { "scottmckendry/cyberdream.nvim", name = "Theme - cyberdream", lazy = true },

    { "catppuccin/nvim", name = "(Theme) catppuccin", lazy = true },
    { "Mofiqul/dracula.nvim", name = "(Theme) dracula", lazy = true },
    { "kepano/flexoki-neovim", name = "(Theme) flexoki", lazy = true },
    { "nyoom-engineering/oxocarbon.nvim", name = "(Theme) oxocarbon", lazy = true },
    { "bluz71/vim-moonfly-colors", name = "(Theme) moonfly", lazy = true },
    { "rebelot/kanagawa.nvim", name = "(Theme) kanagawa", lazy = true },
    { "AlexvZyl/nordic.nvim", name = "(Theme) nordic", lazy = true },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        ---@class tokyonight.Config
        ---@field on_colors fun(colors: ColorScheme)
        ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
        opts = {
            style = "moon",
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
            },
            ---@param highlights tokyonight.Highlights
            ---@param colors ColorScheme
            on_highlights = function(highlight_group, colors)
                highlight_group["@lsp.typemod.variable.readonly"] = "@constant"
            end,
        },
    },
}
