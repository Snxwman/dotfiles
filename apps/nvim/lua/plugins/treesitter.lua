return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        vim.filetype.add {
            extension = {
                zsh = "sh",
                sh = "sh"
            },
            filename = {
                [".zshrc"] = "sh",
                [".zshenv"] = "sh"
            }
        }

        configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "clojure",
                "cmake",
                "commonlisp",
                "cpp",
                "css",
                "csv",
                "dockerfile",
                "elixir",
                "fennel",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "glsl",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "gowork",
                "gpg",
                "html",
                "ini",
                "java",
                "javascript",
                "jq",
                "json",
                "json5",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "passwd",
                "pem",
                "rasi",
                "rust",
                "sql",
                "ssh_config",
                "svelte",
                "sxhkdrc",
                "templ",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "yuck",
            },
            highlight = { enable = true },
            indent = { enable = true},
        })
    end
}
