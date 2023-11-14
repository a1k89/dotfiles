local setup, indent_blankline = pcall(require, 'ibl')
if not setup then return end

indent_blankline.setup({
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "Function", "Label" },
    }
})

