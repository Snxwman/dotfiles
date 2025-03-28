return {
    {
        "vlime/vlime",
        enabled = false,
        ft = { "lisp", "lisp_vlime" },
        config = function()
           rtp = "vim/"
        end
    },
    {
        -- TODO: Move to langs/lisp.lua
        "eraserhd/parinfer-rust",
        enabled = false,
    },
}
