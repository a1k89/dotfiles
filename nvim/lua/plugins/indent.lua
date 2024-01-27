local setup, indent_blankline = pcall(require, 'ibl')
if not setup then return end

local highlight = {
    "CursorColumn",
    "Whitespace",
}
    
indent_blankline.setup({
    indent = {
        highlight = highlight,
        char = '┊', 
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "Function", "Label", },
    }
})

