local setup, treesitter = pcall(require, "nvim-treesitter.configs")
if not setup then return end

treesitter.setup {
    ensure_installed = { "python", "javascript", "typescript", "go","lua", "query"},
    sync_install = true,
    indent = { enable = true },
    highlight = {
        enable = true
    }
}


