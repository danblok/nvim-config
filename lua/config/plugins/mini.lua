return {
    {
        "echasnovski/mini.ai",
        config = function()
            require("mini.ai").setup()
        end,
    },
    {
        "echasnovski/mini.basics",
        config = function()
            require("mini.basics").setup()
        end,
    },
    {
        "echasnovski/mini-git",
        main = "mini.git",
        config = function()
            require("mini.git").setup()
        end,
    },
    {
        "echasnovski/mini.diff",
        main = "mini.git",
        config = function()
            require("mini.diff").setup({
                view = {
                    style = 'sign',
                    signs = { add = '+', change = '~', delete = '-' },
                },
            })
        end,
    },
    {
        "echasnovski/mini.trailspace",
        config = function()
            require("mini.trailspace").setup()
        end,
    },
    {
        "echasnovski/mini.move",
        main = "mini.git",
        config = function()
            require("mini.move").setup({
                mappings = {
                    left = "H",
                    right = "L",
                    down = "J",
                    up = "K",

                    -- Disable line shifting in normal mode
                    line_left = "",
                    line_right = "",
                    line_down = "",
                    line_up = "",
                },
            })
        end,
    }
    -- {
    --     "echasnovski/mini.completion",
    --     config = function()
    --         require("mini.completion").setup()
    --     end,
    -- },
}
