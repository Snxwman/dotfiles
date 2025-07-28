local map_list = function(list, func)
    for i, item in ipairs(list) do
        list[i] = func(item)
    end
end

local min_to_ms = function(mins)
    return mins * 60 * 1000
end

return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    init = function(_)
        local home = vim.fn.expand("$HOME")
        local distro = vim.fn.system("lsb_release --id --short"):gsub("\n", "")

        -- Table must be a list of paths.
        -- Whitelist is strict, if any paths are present, ALL files must be in whitelist
        -- local whitelist = {  -- TODO: Impl syntax for exact path, one level inside dir, and starts with
        --     "~/src",
        --     "~/.config",
        --     "~/.scripts",
        --     "/etc",
        -- }
        local whitelist = {}
        local blacklist = {}

        map_list(whitelist, vim.fs.normalize)
        map_list(blacklist, vim.fs.normalize)

        local base = {
            workspace = "Working on ",
            editing = "Editing ",
            file_browser = "Browsing file exploer ",
        }

        local styles = {
            stars = "**********",
            question_marks = "����������",
            text_redacted = "[REDACTED]",
            blackout = "██████████",
        }

        -- TODO: Impl random unicode chars, random varying blocks, dynamic len (rand or deterministic)
        -- TODO: Impl chosing a random option
        local redacted = {
            styles = styles,
            workspace = base.workspace .. styles.blackout,
            editing = base.editing .. styles.blackout,
            button = {
                label = "View on GitHub",
                url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            }
        }

        -- Place more specific paths lower to override less specific ones
        -- Needed becuase k,v tables are not ordered
        local overrides = {
            vim.fn.stdpath("data") .. "/leetcode",
            home .. "/.config/nvim/lua/plugins",
            home .. "/.config/nvim",
            home .. "/.config/qtile",
            home .. "/.config/ghostty",
            home .. "/.config/.aliaes",
            home .. "/.config/.zsh",
            home .. "/.scripts",
            "/etc",
        }
        local override_fmts = {
            ["/etc"] = {
                workspace = "Configuring " .. distro .. " Linux",
                editing = base.editing .. "${current_file}",
                buttons = {}
            },
            [home .. "/.scripts"] = {
                workspace = "Writing shell scripts",
            },
            [home .. "/.config/.aliases"] = {
                workspace = base.workspace .. "aliases",
            },
            [home .. "/.config/.zsh"] = {
                workspace = base.workspace .. "zsh config",
            },
            [home .. "/.config/ghostty"] = {
                workspace = base.workspace .. "ghostty config",
            },
            [home .. "/.config/nvim"] = {
                workspace = base.workspace .. "neovim config",
            },
            [home .. "/.config/nvim/lua/plugins"] = {
                workspace = base.workspace .. "neovim plugin configs",
            },
            [home .. "/.config/qtile"] = {
                workspace = base.workspace .. "qtile config"
            },
            -- TODO: App specific stuff, would be better added in lazily some way
            [vim.fn.stdpath("data") .. "/leetcode"] = {
                workspace = "Grinding LeetCode",
            }
        }

        local allowed_path = function(path)
            -- local blacklist = vim.g.discord.blacklist
            -- local whitelist = vim.g.discord.whitelist

            if #blacklist ~= 0 then
                for _, prefix in ipairs(blacklist) do
                    if vim.startswith(path, prefix) then
                        return false
                    end
                end
            end

            if #whitelist == 0 then
                return true
            else
                for _, prefix in ipairs(whitelist) do
                    if vim.startswith(path, prefix) then
                        return true
                    end
                end
            end
        end

        -- TODO: Custom tooltip format - "[Solved] [Premium] [Daily] [Difficulty] Number. Problem name"
        -- TODO: Take language into account for solved
        local leetcode = {
            workspace = "Grinding LeetCode",
            picker = "Selecting a problem",
            menu = function()
                -- Checks if the menu were viewing is in the same tabpage as a window with a problem's buffer
                -- if so, use the problem's detail message, otherwise use "In main menu".
                -- Assumes that the main menu is in leetcode.nvim's 1st tabpage.
                local tabpage = vim.api.nvim_get_current_tabpage()

                if tabpage ~= 1 then
                    local tabpage_win_ids = vim.api.nvim_tabpage_list_wins(tabpage)

                    for _, winid in ipairs(tabpage_win_ids) do
                        local bufnr = vim.api.nvim_win_get_buf(winid)
                        local filename = vim.api.nvim_buf_get_name(bufnr)
                        if vim.g.leetcode.questions[filename] ~= nil then
                            return vim.g.discord.fmt.apps.leetcode.problem(filename)
                        end
                    end
                end

                return "In main menu"
            end,
            problem = function(current_file)
                -- TODO: find out how to tell if a problem is the daily problem
                local emojis = {
                    easy = "🟢", medium = "🟡", hard = "🔴",
                    daily = "📆", solved = "✅", premium = "💎"
                }
                local leetcode = vim.g.leetcode
                local question = leetcode.questions[current_file]

                if question ~= nil then
                    local emoji_str = question.is_solved and emojis.solved or ""
                    emoji_str = emoji_str .. (question.is_daily and emojis.daily or "")
                    emoji_str = emoji_str .. emojis[question.difficulty]

                    return emoji_str .. " " .. question.number .. ". " .. question.name
                else
                    return ""
                end
            end
        }

        vim.g.discord = {
            blacklist = blacklist,
            whitelist = whitelist,
            allowed_path = allowed_path,
            current_file = "",
            current_buffer = "",
            current_workspace_path = "",
            current_workspace_git_root = "",
            fmt = {
                base = base,
                redacted = redacted,
                overrides = overrides,
                override_fmts = override_fmts,
                plugin_managers = {
                    lazy = "Managing plugins with lazy.nvim",
                    mason = "Managing lsp installs with mason",
                },
                apps = {
                    leetcode = leetcode,
                }
            }
        }
    end,
    -- keys = function(_, _)
    -- end,
    opts = {
        -- log_level = vim.log.levels.TRACE,
        editor = {
            tooltip = "Neovim",
        },
        display = {
            flavor = "accent",
            swap_fields = true,
            swap_icons = true,
        },
        timestamp = {
            reset_on_idle = true,
        },
        idle = {
            timeout = min_to_ms(1 * 60),
            show_status = false,
        },
        hooks = {
            -- pre_activity = function(opts)
            --     local log = require("util.log").debug()
            --     log.debug(opts)
            -- end
        },
        variables = {
            -- TODO: Might be able to do conditional formatting here instead of in text functions

            current_file = function() return vim.fn.expand("%:p") end
        },
        text = {
            -- TODO: :messages, healthchecks, trouble
            workspace = function(opts)
                local fmt = vim.g.discord.fmt
                local current_file = vim.fn.expand("%:p")

                if not vim.g.discord.allowed_path(current_file) then
                    return fmt.redacted.workspace
                end

                for _, path in ipairs(fmt.overrides) do
                    local realpath = vim.uv.fs_realpath(path) or path

                    if opts.workspace == "leetcode" then
                        return "Grinding LeetCode"
                    end

                    if vim.startswith(current_file, realpath) then
                        return fmt.override_fmts[path].workspace
                    end
                end

                if opts.workspace == vim.fn.expand("~") then
                    return "Working on files in ~/"
                end

                if opts.repo_url ~= nil then
                    return fmt.base.workspace .. opts.workspace
                end

                -- TODO: Make unique
                return fmt.base.workspace .. opts.workspace
            end,
            editing = function(opts)
                local fmt = vim.g.discord.fmt
                local current_file = vim.fn.expand("%:p")

                if opts.workspace == "leetcode" then
                    if current_file ~= "" then
                        return fmt.apps.leetcode.problem(current_file)
                    else
                        -- local log = require("util.log").debug()
                        -- log.debug(opts)
                        -- Suppress "Editing a new file" message
                        -- TODO: Handle when in the Leet console
                        return ""
                    end
                end

                for _, path in ipairs(fmt.overrides) do
                    local realpath = vim.uv.fs_realpath(path) or path

                    if vim.startswith(current_file, realpath) then
                        local msg = fmt.override_fmts[path].editing
                        if msg ~= nil then
                            return msg
                        end
                    end
                end

                return fmt.base.editing .. opts.filename
            end,
            viewing = function(opts)
                local current_file = vim.fn.expand("%:p")

                if opts.workspace == "leetcode" and current_file == "" then
                    return vim.g.discord.fmt.apps.leetcode.menu()
                end

                return "Viewing " .. opts.filename
            end,
            file_browser = function(opts)
                local fmt = vim.g.discord.fmt

                if opts.workspace == "leetcode" then
                    -- BUG: When telescope opens it is picked up as "nofile".
                    -- After losing and regaining focus it is picked up correctly
                    -- TODO: Need to distinguish between different pickers (eg. problem, lang)
                    return fmt.apps.leetcode.picker
                end

                return fmt.base.file_browser
            end,
            plugin_manager = function(opts)
                local fmt = vim.g.discord.fmt
                local plugin_manager = string.lower(opts.name)
                return fmt.plugin_managers[plugin_manager]
            end,
            dashboard = function()
                return "On my dashbord"
            end,
            test = false,
            debug = false,
            terminal = false,
            notes = false,
            games = false,
        },
        -- buttons = {
        --     {
        --         label = function(opts)
        --             local msgs = vim.g.discord.msgs
        --             local current_file = vim.fn.expand("%:p")
        --             if not vim.g.discord.allowed_path(current_file) then
        --                 return msgs.redacted.button.label
        --             end
        --
        --             if opts.repo_url ~= nil then
        --                 return "Open " .. opts.workspace .. " on GitHub"
        --             end
        --
        --             return "Click me"
        --         end,
        --         url = function(opts)
        --             local msgs = vim.g.discord.msgs
        --             local current_file = vim.fn.expand("%:p")
        --             if not vim.g.discord.allowed_path(current_file) then
        --                 return msgs.redacted.button.url
        --             end
        --
        --             -- TODO: Check if repo is private
        --             if opts.repo_url ~= nil then
        --                 return opts.repo_url
        --             end
        --         end
        --     }
        -- }
    }
}
