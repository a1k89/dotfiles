vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.swapfile = false
vim.opt.numberwidth = 5
vim.opt.scrolloff = 32
vim.opt.showmode = true
vim.opt.list = true
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

vim.opt.listchars = {
    extends = "┊",
    precedes = "‹",
    nbsp = "␣",
    trail = "·",
    tab = "┊ ",
}
