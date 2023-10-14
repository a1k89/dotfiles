local setup, indent_blankline = pcall(require, 'ib')
if not setup then return end

local highlight = {
    "CursorColumn",
    "Whitespace",
}

indent_blankline.setup {
    indent = {highlight = highlight, char = ""},
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = {
        enabled = false
    },
}
