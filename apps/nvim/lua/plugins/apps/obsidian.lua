return {
    "epwalsh/obsidian.nvim",
    enabled = false,
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut "~" here you need to call "vim.fn.expand".
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/documents/obsidian/**/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/documents/obsidian/**/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Personal",
                path = "~/documents/obsidian/Personal",
            },
        },
    },
}
