return {
    cmd = { "golangci-lint-langserver" },
    filetypes = { "go", "gomod" },
    root_markers = { "go.mod" },
    init_options = {
        command = { "golangci-lint", "run", "--issues-exit-code=1" }
    },
}
