return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui", config = true },
            { "leoluz/nvim-dap-go", config = true },
            { "nvim-neotest/nvim-nio" },
        },
        keys = {
            { "<F2>", ":lua require'dap'.step_over()<CR>", { desc = "Step over", silent = true } },
            { "<F3>", ":lua require'dap'.step_into()<CR>", { desc = "Step into", silent = true } },
            { "<F4>", ":lua require'dap'.step_out()<CR>", { desc = "Step out", silent = true } },
            { "<F5>", ":lua require'dap'.continue()<CR>", { desc = "Continue", silent = true } },
            {
                "<leader>db",
                ":lua require'dap'.toggle_breakpoint()<CR>",
                { desc = "Toggel breakpoint", silent = true },
            },
            { "<leader>dB", ":lua require'dap'.set_breakpoint()<CR>", { desc = "Set breakpoint", silent = true } },
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
