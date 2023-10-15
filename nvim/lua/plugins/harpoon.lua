local setup, harpoon = pcall(require, "harpoon")
if not setup then return end

harpoon.setup({
    global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon" },
    mark_branch = false,
    tabline = false,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
}
})
