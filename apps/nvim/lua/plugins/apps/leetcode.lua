-- Source: https://github.com/kawre/leetcode.nvim/issues/86#issuecomment-2145070626
local rust_no_cargo_fix = function()
    local file_extension = vim.fn.expand("%:e")
    if file_extension == "rs" then
        local target_dir = vim.fn.stdpath("data") .. "/leetcode"
        local output_file = target_dir .. "/rust-project.json"

        if vim.fn.isdirectory(target_dir) == 1 then
            local crates = ""
            local next = ""

            local rs_files = vim.fn.globpath(target_dir, "*.rs", false, true)
            for _, f in ipairs(rs_files) do
                local file_path = f
                crates = crates ..
                next ..
                "{\"root_module\": \"" .. file_path .. "\",\"edition\": \"2021\",\"deps\": []}"
                next = ","
            end

            if crates == "" then
                print("No .rs files found in directory: " .. target_dir)
                return
            end

            local sysroot_src = vim.fn.system("rustc --print sysroot"):gsub("\n", "") ..
            "/lib/rustlib/src/rust/library"

            local json_content = "{\"sysroot_src\": \"" ..
            sysroot_src .. "\", \"crates\": [" .. crates .. "]}"

            local file = io.open(output_file, "w")
            if file then
                file:write(json_content)
                file:close()

                local clients = vim.lsp.get_clients()
                local rust_analyzer_attached = false
                for _, client in ipairs(clients) do
                    if client.name == "rust_analyzer" then
                        rust_analyzer_attached = true
                        break
                    end
                end

                if rust_analyzer_attached then
                    vim.cmd("LspRestart rust_analyzer")
                end
            else
                print("Failed to open file: " .. output_file)
            end
        else
            print("Directory " .. target_dir .. " does not exist.")
        end
    end
end

return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            -- {
            --     "3rd/image.nvim",
            --     build = false,
            --     opts = {
            --         processor = "magick_cli",
            --         max_width_window_percentage = 80,
            --         window_overlap_clear_enabled = false,
            --     },
            -- }
        },
        opts = {
            lang = "python3",
            cache = { update_interval = 86400 },  -- One day in seconds
            -- image_support = true,
            description = {
                position = "left",
                width = "30%",
            },
            hooks = {
                ["question_enter"] = {
                    function(data)
                        local filename = data.file.filename
                        local solved = false
                        if data.cache.status == "ac" then
                            solved = true
                        end

                        local question = {
                            [filename] = {
                                difficulty = data.q.difficulty:lower(),
                                number = data.q.frontend_id,
                                name = data.q.title,
                                liked = data.q.likes,
                                dislikes = data.q.dislikes,
                                stats = data.q.stats,
                                is_solved = solved,
                                is_daily = false,  -- TODO: Not part of data
                                is_starred = data.cache.starred,
                                is_premium = data.q.is_paid_only,
                                file = data.file.filename,
                                link = data.cache.link,
                            }
                        }

                        local leetcode = vim.g.leetcode
                        leetcode.questions = vim.tbl_deep_extend("force", leetcode.questions, question)
                        vim.g.leetcode = leetcode

                        rust_no_cargo_fix()
                    end
                },
            },
        },
        config = function(_, opts)
            vim.g.leetcode = {
                questions = {}
            }

            require("leetcode").setup(opts)
            require('which-key').add({
                {
                    icon = { icon = "󰬓 ", color = "yellow" },
                    { "<leader>L", group = "Leetcode" },
                    { "<leader>Lc", "<cmd>Leet console<cr>", desc = "[Leet] Open leet console" },
                    { "<leader>Li", "<cmd>Leet info<cr>", desc = "[Leet] Open question info" },
                    { "<leader>Ll", "<cmd>Leet lang<cr>", desc = "[Leet] Change the current language" },
                    { "<leader>Lm", "<cmd>Leet menu<cr>", desc = "[Leet] Return to main menu" },
                    { "<leader>Lp", "<cmd>Leet list<cr>", desc = "[Leet] Open problem picker" },
                    { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "[Leet] Submit answer" },
                    { "<leader>Lt", "<cmd>Leet test<cr>", desc = "[Leet] Test answer" },
                },
            })
        end
    },
}
