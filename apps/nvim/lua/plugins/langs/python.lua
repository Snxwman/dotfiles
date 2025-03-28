return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "python",
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "basedpyright",
                "ruff",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                basedpyright = {
                    settings = {
                        basedpyright = {
                            disableOrganizeImports = true,
                            analysis = {
                                diagnosticMode = "openFilesOnly",
                                ignore = { "*" },  -- Disables all analysis (to use ruff exclusively)
                                inlayHints = {
                                    variableTypes = false,
                                    callArgumentNames = false,
                                    functionReturnTypes = false,
                                    genericTypes = false,
                                }
                            }
                        }
                    }
                },

                ruff = {
                    init_options = {
                        settings = {
                            configurationPreference = "filesystemFirst",
                            lineLength = 120,
                            -- lint = {
                            --     -- select = { "F", "E4", "E7", "E9" }  -- ruff defaults
                            --     extendSelect = {
                            --         "A",     -- flake8-builtins
                            --         "B",     -- flake8-bugbear
                            --         "D",     -- pydocstyle
                            --         "E",     -- pycodestyle (error)
                            --         "G",     -- flake8-logging-format
                            --         "I",     -- isort
                            --         "N",     -- pep8-naming
                            --         "S",     -- flake8-bandit
                            --         "W",     -- pycodestyle (warning)
                            --         "C4",    -- flake8-comprehensions
                            --         "EM",    -- flake8-errmsg
                            --         "FA",    -- flake8-future-annotations
                            --         "PL",    -- pylint
                            --         "UP",    -- pyupgrade
                            --         "ANN",   -- flake8-annotations
                            --         "ARG",   -- flake8-unused-arguments
                            --         "COM",   -- flake8-commas
                            --         "DOC",   -- pydoclint
                            --         "DTZ",   -- flake8-datetimez
                            --         "ICN",   -- flake8-import-conventions
                            --         "INP",   -- flake8-no-pep420
                            --         "ISC",   -- flake8-implicit-str-concat
                            --         "LOG",   -- flake8-logging
                            --         "PIE",   -- flake8-pie
                            --         "PLE",   -- pylint (error)
                            --         "PLR",   -- pylint (refactor)
                            --         "PLW",   -- pylint (warning)
                            --         "PTH",   -- flake8-use-pathlib
                            --         "RUF",   -- ruff-specific rules
                            --         "SIM",   -- flake8-simplify
                            --         "TID",   -- flake8-tidy-imports
                            --         "TRY",   -- tryceratops
                            --         "T20",   -- flake8-print
                            --         "FURB",  -- refurb
                            --         "PERF",  -- perflint
                            --         "SLOT",  -- flake8-slots
                            --     },
                            -- },
                        }
                    }
                }
            }
        },
    },
}

