local setup, neotree = pcall(require, "neo-tree")
if not setup then
    return
end

neotree.setup({
    enable_git_status = false,
    enable_diagnostics = false,
    filesystem = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false
    }
})
