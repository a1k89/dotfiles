-- n, v, i, t = mode names
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Tab bar
map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
map('n', '<Space><Tab>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fx', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gt', builtin.git_status, {})
vim.keymap.set('n', '<leader>hr', "<Cmd>Telescope harpoon marks<CR>")

-- LspSaga
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- Goto-preivew
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", {noremap=true})
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})


-- Harpoon
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>hl", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})

