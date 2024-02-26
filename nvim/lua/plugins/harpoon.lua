local setup, harpoon = pcall(require, "harpoon")
if not setup then return end

harpoon:setup({})

vim.keymap.set("n", "<leader>hl", function()  local harpoon = require("harpoon")  harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)

