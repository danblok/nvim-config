return {
    cmd = { "lua-language-server" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    filetypes = { "lua" },
    settings = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = { disable = { "missing-fields" } },
    },
}
