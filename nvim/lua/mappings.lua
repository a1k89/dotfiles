-- n, v, i, t = mode names
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Navigations
vim.keymap.set("n", "<leader>e", ":Neotree toggle<cr>") -- toggle file explorer
vim.keymap.set("n", "nt", ":Neotree filesystem reveal float<CR>")

-- Tab bar
map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
map("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})


-- Goto-preivew
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })

vim.keymap.set("n", "<leader>td", function()
    if vim.b.show_diagnostics then
        vim.diagnostic.hide()
        vim.b.show_diagnostics = false
    else
        vim.diagnostic.show()
        vim.b.show_diagnostics = true
    end
end, nil, "Toggle diagnostics")


vim.keymap.set("n", "<leader>g", "<Plug>RestNvim", {})
vim.keymap.set("n", "<leader>gg", "<Plug>RestNvimPreview", {})
