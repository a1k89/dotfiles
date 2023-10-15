local setup, barbar = pcall(require, "barbar")
if not setup then return end

barbar.setup {
	tabpages = true,
	minimum_padding = 5,
	auto_hide = false,
	clickable = false,
	animation = false,
	icons = {
		buffer_index = true,
		diagnostics = {}
	},
	sidebar_filetypes = {
		NvimTree = true,
		undotree = {text = 'undotree'},
		['neo-tree'] = {event = 'BufWipeout'},
		Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
	  },
}
vim.g.barbar_auto_setup = false
