return {
    "ThePrimeagen/harpoon",
    keys = function(_, _)
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        require("which-key").add({
            {
                { "<leader>h", group = "harpoon" },
                icon = { icon = "󱡅 ", color = "orange" },
                { "<leader>ha", mark.add_file, desc = "[Harpoon] Add mark"},

                { "<leader>hm", ui.toggle_quick_menu, desc = "[Harpoon] Open quick menu" },
                { "<leader>hf", ui.nav_next, desc = "[Harpoon] Go to next mark"},
                { "<leader>hb", ui.nav_prev, desc = "[Harpoon] Go to prev mark"},
                { "<C-1>", function() ui.nav_file(1) end, desc = "[Harpoon] Jump to file 1"},
                { "<C-2>", function() ui.nav_file(2) end, desc = "[Harpoon] Jump to file 2"},
                { "<C-3>", function() ui.nav_file(3) end, desc = "[Harpoon] Jump to file 3"},
                { "<C-4>", function() ui.nav_file(4) end, desc = "[Harpoon] Jump to file 4"},
                { "<C-5>", function() ui.nav_file(5) end, desc = "[Harpoon] Jump to file 5"},
            }
        })
    end,
}
