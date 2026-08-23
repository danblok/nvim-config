---@param name string
local function augroup(name)
    return vim.api.nvim_create_augroup("aboba_" .. name, { clear = true })
end


---@param bufnr integer
local function attach_common_keymaps(bufnr)
    local map = vim.keymap.set
    local fzf = require("fzf-lua")

    map("n", "<leader>cd", fzf.lsp_document_diagnostics, { desc = "[C]ode diagnostics [D]ocument", buf = bufnr })
    map("n", "<leader>cw", fzf.lsp_workspace_diagnostics, { desc = "[C]ode diagnosticts [w]orkspace", buf = bufnr })
    map("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols", buf = bufnr })
    map("n", "<leader>ws", fzf.lsp_live_workspace_symbols, { desc = "[W]orkspace [S]ymbols", buf = bufnr })
end

-- No need to call LspAttach to enable completion,
-- because blink.cmp does this for me automagically
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lps_attach"),

    callback = function(ev)
        local bufnr = ev.buf
        local map = vim.keymap.set
        local fzf = require("fzf-lua")

        fzf.register_ui_select({}, true)
        attach_common_keymaps(bufnr)
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buf = bufnr })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buf = bufnr })
        map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buf = bufnr })

        -- map("n", "<leader>gw", fzf.grep_cword, { desc = "[G]rep [W]ord", buf = bufnr }) -- somnitelno
        map("n", "<leader>gr", fzf.lsp_references, { desc = "[G]oto [R]eferences", buf = bufnr })
        map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, { desc = "[C]ode [A]ction", buf = bufnr })

        map("n", "tf", fzf.lsp_typedefs, { desc = "[T]ype [D]efs", buf = bufnr })
        map("n", "gD", fzf.lsp_declarations, { desc = "[G]oto [D]eclarations", buf = bufnr })
        map("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition", buf = bufnr })
        map("n", "gi", fzf.lsp_implementations, { desc = "[G]oto [I]mplementation", buf = bufnr })
        map("n", "si", fzf.lsp_incoming_calls, { desc = "[S]earch [I]ncoming calls", buf = bufnr })
        map("n", "so", fzf.lsp_outgoing_calls, { desc = "[S]earch [O]utgoing calls", buf = bufnr })
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("vim_enter"),
    callback = function(ev)
        local bufnr = ev.buf
        local map = vim.keymap.set
        local fzf = require("fzf-lua")

        map("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles", buf = bufnr })
        map("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch [G]rep", buf = bufnr })
        map("n", "<leader>cd", fzf.lsp_document_diagnostics, { desc = "[C]ode diagnostics [D]ocument", buf = bufnr })
        map("n", "<leader>cw", fzf.lsp_workspace_diagnostics, { desc = "[C]ode diagnosticts [w]orkspace", buf = bufnr })
        map("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols", buf = bufnr })
        map("n", "<leader>ws", fzf.lsp_live_workspace_symbols, { desc = "[W]orkspace [S]ymbols", buf = bufnr })
    end,

})


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- Make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer"
            })
        end)
    end,
})

-- Spell for text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

local group = vim.api.nvim_create_augroup("TelescopeWinBorder", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

        if string.find(filetype, "TelescopePrompt") or string.find(filetype, "TelescopeResults") then
            vim.go.winborder = "none" -- Set to "none" so there is no double borders
        end
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

        if string.find(filetype, "TelescopePrompt") or string.find(filetype, "TelescopeResults") then
            vim.go.winborder = "rounded" -- Restore to "rounded"
        end
    end,
})
