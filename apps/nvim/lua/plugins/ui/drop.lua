return {
    {
        "folke/drop.nvim",
        opts = {
            -- theme = "matrix",
            themes = {
                { theme = "new_year", month = 1, day = 1 },
                { theme = "us_independence_day", month = 7, day = 4 },
                { theme = "halloween", from = {month = 10, day = 1}, to = { month = 11, day = 1} },
                { theme = "us_thanksgiving", from = { month = 11, day = 18}, to = { month = 11, day = 30 }},
                { theme = "xmas", from = { month = 12, day = 14 }, to = { month = 12, day = 28 } },
                { theme = "spring", from = { month = 3, day = 19 }, to = { month = 5, day = 31 } },
                { theme = "summer", from = { month = 6, day = 1 }, to = { month = 9, day = 21 } },
                { theme = "leaves", from = { month = 9, day = 22 }, to = { month = 11, day = 17 } },
                { theme = "snow", from = { month = 12, day = 1 }, to = { month = 3, day = 18 } },
            },
            max = 50, -- maximum number of drops on the screen
            screensaver = 1000 * 60 * 15, -- show after 5 minutes. Set to false, to disable
        },
    }
}
