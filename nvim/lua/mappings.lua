-- n, v, i, t = mode names
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Usefule
map('n', 'C-c', '<Cmd>%y+<CR>', opts)
-- Tab bar
map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
map('n', '<Space><Tab>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

-- Gitsigns
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', opts)
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', opts)
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', opts)

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

-- Harpoon
vim.keymap.set('n', '<leader>hx', require('harpoon.mark').add_file)
vim.keymap.set('n', '<leader>hn', require('harpoon.ui').nav_next)
vim.keymap.set('n', '<leader>hp', require('harpoon.ui').nav_prev)

-- LspSaga
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

