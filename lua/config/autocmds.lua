local function augroup(name)
    return vim.api.nvim_create_augroup("aboba_" .. name, { clear = true })
end

-- No need to call LspAttach to enable completion,
-- because blink.cmp does this for me automagically

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
                desc = "Quit buffer",
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
