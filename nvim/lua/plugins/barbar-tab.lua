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
		diagnostics = {
      		[vim.diagnostic.severity.ERROR] = {enabled = true, icon = "E"},
      		[vim.diagnostic.severity.WARN] = {enabled = true},
      		[vim.diagnostic.severity.INFO] = {enabled = true},
      		[vim.diagnostic.severity.HINT] = {enabled = true},
    	}
	},
	sidebar_filetypes = {
		NvimTree = true,
		undotree = {text = 'undotree'},
		['neo-tree'] = {event = 'BufWipeout'},
		Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
	  },
}
vim.g.barbar_auto_setup = false
