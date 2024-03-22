-- n, v, i, t = mode names
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", ":Neotree toggle<cr>") -- toggle file explorer
vim.keymap.set("n", "nt", ":Neotree filesystem reveal left<CR>")

-- Tab bar
map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
map("n", "<Space><Tab>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fmk", "<cmd>:Telescope make<CR>", opts)

vim.keymap.set("n", ",hl", "<Cmd>.DiffviewFileHistory --follow<CR>", { desc = "File history for the current line" })
vim.keymap.set(
    "v",
    ",hl",
    "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
    { desc = "File history for the visual selection" }
)
-- Goto-preivew
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })

vim.keymap.set("n", ",d", "<cmd>DiffviewOpen<cr>", { nowait = true })
vim.keymap.set("n", ",dc", "<cmd>DiffviewClose<cr>", { nowait = true })
vim.keymap.set("n", ",hh", "<cmd>DiffviewFileHistory<cr>", { nowait = true })
vim.keymap.set("n", ",hf", "<cmd>DiffviewFileHistory --follow %<cr>", { nowait = true })
vim.keymap.set("n", ",hl", function()
    local current_line = vim.fn.line(".")
    local file = vim.fn.expand("%")
    local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", current_line, current_line, file)
    vim.cmd(cmd)
end, {})
vim.keymap.set("n", "<leader>td", function()
    if vim.b.show_diagnostics then
        vim.diagnostic.hide()
        vim.b.show_diagnostics = false
    else
        vim.diagnostic.show()
        vim.b.show_diagnostics = true
    end
end, nil, "Toggle diagnostics")


-- Rest
vim.keymap.set("n", "<leader>g", "<Plug>RestNvim", {})
vim.keymap.set("n", "<leader>gg", "<Plug>RestNvimPreview", {})

-- Quotes
vim.keymap.set("n", "<leader>wsq", 'ciw""<Esc>P', { desc = "Word Surround Quotes" })
