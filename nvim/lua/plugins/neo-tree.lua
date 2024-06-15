local setup, neotree = pcall(require, "neo-tree")
if not setup then
    return
end

neotree.setup({
    enable_git_status = false,
    enable_diagnostics = true,
    filesystem = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false
    },
    default_component_configs = {
        last_modified = {
            enabled = false,
            required_width = 88, -- min width of window required to show this column
        },
        created = {
            enabled = false,
            required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
            enabled = false,
        },
    },
    window = {
        position = "float",
        width = 60,
        mapping_options = {
            noremap = true,
            nowait = true,
        }
    }
})
