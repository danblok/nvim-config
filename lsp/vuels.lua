local function get_typescript_server_path()
    local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = vim.fn.getcwd(), upward = true })[1])
    return project_root and (project_root .. '/node_modules/typescript/lib') or ''
end

return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "html", "vue", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init_options = {
        vue = {
            hybridMode = false,
        },
        typescript = {
            tsdk = get_typescript_server_path(),
        },
    },
    root_markers = { "package.json" },
}
