return {
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
                    d = { "%f[%d]%d+" },                                                          -- digits
                    e = {                                                                         -- Word with case
                        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                        "^().*()$",
                    },
                    u = ai.gen_spec.function_call(),                           -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                },
            }
        end,
    },
    {
        "echasnovski/mini.basics",
        event = "VeryLazy",
        config = function()
            require("mini.basics").setup()
        end,
    },
    {
        "echasnovski/mini-git",
        event = "VeryLazy",
        main = "mini.git",
        config = function()
            require("mini.git").setup()
        end,
    },
    {
        "echasnovski/mini.diff",
        event = "VeryLazy",
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
        event = "VeryLazy",
        config = function()
            require("mini.trailspace").setup()
        end,
    },
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
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
}
