local setup, catppuccin = pcall(require, "catppuccin")
if not setup then return end

catppuccin.setup()
vim.cmd.colorscheme "catppuccin"

