return {
    cmd = { "pylyzer", "--server" },
    filetypes = { "python" },
    root_markers = { "setup.py", "tox.ini", "requirements.txt", "Pipfile", "pyproject.toml", ".git" },
    python = {
        checkOnType = false,
        diagnostics = true,
        inlayHints = true,
        smartCompletion = true
    }
}
