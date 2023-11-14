-- n, v, i, t = mode names
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tab bar
map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
map('n', '<Space><Tab>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fx', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>")
vim.keymap.set('n', '<leader>gt', builtin.git_status, {})
vim.keymap.set('n', '<leader>hr', "<Cmd>Telescope harpoon marks<CR>")

-- LspSaga
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

